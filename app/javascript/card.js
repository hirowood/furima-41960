// app/javascript/card.js
'use strict';

// グローバル変数としてpayjpを定義
let payjp;

async function createPayjpToken(numberElement) {
  try {
    // すでに存在するトークン入力フィールドを削除
    const existingToken = document.querySelector('input[name="token"]');
    if (existingToken) {
      existingToken.remove();
    }

    // トークン生成
    console.log('トークン生成を試みます...');
    const response = await payjp.createToken(numberElement);
    console.log('PayJP レスポンス:', response);

    if (response.error) {
      console.error('PayJP エラー:', response.error);
      alert(`カード情報エラー: ${response.error.message}`);
      return false;
    }

    // トークンをフォームに追加
    const token = response.id;
    const renderDom = document.querySelector('#charge-form');
    const tokenObj = `<input value="${token}" name="token" type="hidden">`;
    renderDom.insertAdjacentHTML("beforeend", tokenObj);
    
    console.log('トークン生成成功:', token);
    return true;
  } catch (error) {
    console.error('予期せぬエラー:', error);
    alert('予期せぬエラーが発生しました');
    return false;
  }
}

const pay = () => {
  console.log('pay関数が開始されました');
  
  // 公開キーが設定されているか確認
  if (typeof gon === 'undefined') {
    console.error('gonオブジェクトがありません');
    return;
  }
  
  if (!gon.public_key) {
    console.error('公開キーが設定されていません');
    return;
  }
  
  const publicKey = gon.public_key;
  console.log('公開キー:', publicKey);
  
  try {
    // PayJPの初期化
    payjp = Payjp(publicKey);
    
    // 要素の存在確認
    const numberForm = document.getElementById('number-form');
    const expiryForm = document.getElementById('expiry-form');
    const cvcForm = document.getElementById('cvc-form');
    
    if (!numberForm || !expiryForm || !cvcForm) {
      console.error('フォーム要素が見つかりません');
      return;
    }
    
    // 要素の作成
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');
    
    // 要素のマウント
    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');
    
    // フォームの送信処理
    const form = document.getElementById('charge-form');
    if (!form) {
      console.error('フォームが見つかりません');
      return;
    }
    
    form.addEventListener('submit', async (e) => {
      console.log('フォーム送信イベントが発生しました');
      e.preventDefault();
      
      // ボタンを無効化
      const submitBtn = document.getElementById('button');
      if (submitBtn) submitBtn.disabled = true;
      
      try {
        // トークン生成を待つ
        const result = await createPayjpToken(numberElement);
        
        if (result) {
          console.log('フォームを送信します...');
          numberElement.clear();
          expiryElement.clear();
          cvcElement.clear();
          form.submit();
        } else {
          console.error('トークン生成に失敗しました');
          if (submitBtn) submitBtn.disabled = false;
        }
      } catch (error) {
        console.error('フォーム送信中にエラーが発生しました:', error);
        alert('処理中にエラーが発生しました。もう一度お試しください。');
        if (submitBtn) submitBtn.disabled = false;
      }
    });
  } catch (error) {
    console.error('PayJP初期化中にエラーが発生しました:', error);
  }
};

// イベントリスナーの設定
document.addEventListener("turbo:load", pay);
document.addEventListener("turbo:render", pay);
// Turboがない環境のためのフォールバック
if (typeof Turbo === 'undefined') {
  window.addEventListener("DOMContentLoaded", pay);
}

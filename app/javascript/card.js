// app/javascript/card.js
'use strict';

(() => {
  // -----------------------------
  // 内部フラグ（多重初期化防止）
  // -----------------------------
  let payjp        = null;
  let elements     = null;
  let numberElm    = null;
  let expiryElm    = null;
  let cvcElm       = null;

  // PayJP Elements をアンマウントしてメモリリークを防ぐ
  function destroyElements() {
    [numberElm, expiryElm, cvcElm].forEach(elm => elm?.destroy());
    numberElm = expiryElm = cvcElm = null;
  }

  // -----------------------------
  // メイン処理
  // -----------------------------
  async function initPay() {
    // 既に初期化済みならスキップ
    if (payjp) return;

    // 公開キーの存在チェック
    if (!window.gon?.public_key) {
      console.error('gon.public_key が取得できません');
      return;
    }

    // PayJP 初期化
    payjp    = Payjp(window.gon.public_key);
    elements = payjp.elements();

    // 要素のマウント
    numberElm  = elements.create('cardNumber');
    expiryElm  = elements.create('cardExpiry');
    cvcElm     = elements.create('cardCvc');

    numberElm.mount('#number-form');
    expiryElm.mount('#expiry-form');
    cvcElm.mount('#cvc-form');

    // フォーム送信
    const form = document.getElementById('charge-form');
    form?.addEventListener('submit', handleSubmit);
  }

  // -----------------------------
  // Submit ハンドラ
  // -----------------------------
  async function handleSubmit(e) {
    e.preventDefault();
    const btn = document.getElementById('button');
    btn && (btn.disabled = true);

    try {
      const { id: token, error } = await payjp.createToken(numberElm);

      if (error) {
        alert(`カード情報エラー: ${error.message}`);
        btn && (btn.disabled = false);
        return;
      }

      // トークン hidden フィールドを追加
      e.target.insertAdjacentHTML(
        'beforeend',
        `<input type="hidden" name="token" value="${token}">`
      );

      // フォーム送信
      e.target.submit();
    } catch (err) {
      console.error('Token 生成中にエラー', err);
      alert('決済処理でエラーが発生しました。時間をおいて再度お試しください。');
      btn && (btn.disabled = false);
    } finally {
      // 入力欄クリア
      numberElm?.clear();
      expiryElm?.clear();
      cvcElm?.clear();
    }
  }

  // -----------------------------
  // Turbo イベント
  // -----------------------------
  document.addEventListener('turbo:load', initPay);

  // ページ遷移前にクリーンアップ
  document.addEventListener('turbo:before-render', () => {
    destroyElements();
    payjp = elements = null;
  });
})();

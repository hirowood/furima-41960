function initPay() {
  const form = document.getElementById("charge-form");
  if (!form || form.dataset.initialized === "true") return;
  form.dataset.initialized = "true";

  const publicKey = window.gon?.public_key;
  if (!publicKey) return console.error("PAYJP 公開鍵が取得できません");

  const payjp    = Payjp(publicKey);
  const elements = payjp.elements();
  const numberEl = elements.create("cardNumber");
  const expiryEl = elements.create("cardExpiry");
  const cvcEl    = elements.create("cardCvc");

  numberEl.mount("#number-form");
  expiryEl.mount("#expiry-form");
  cvcEl.mount("#cvc-form");

  form.addEventListener("submit", e => {
    e.preventDefault();
    payjp.createToken(numberEl).then(res => {
      if (res.error) return alert(res.error.message);
      document.getElementById("token-field").value = res.id;
      form.submit();
    });
  });
}

document.addEventListener("turbo:load",   initPay);
document.addEventListener("turbo:render", initPay);



window.addEventListener('turbo:render', () => {
  const price_input = document.querySelector("#item-price");
  if (!price_input) return; 
  const SALES_COMMISSION_PRICE = 0.9
  price_input.addEventListener('input', () => {
    let price = Number(price_input.value)
    let sales = Math.floor(price  * SALES_COMMISSION_PRICE);
    let price_commission = price - sales
    document.querySelector("#add-tax-price").textContent = price_commission;
    document.querySelector('#profit').textContent = sales;
  });
});
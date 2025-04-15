'uer strict';
window.addEventListener('turbo:render', () => {
  const SALES_COMMISSION_PRICE = 0.9
  const price_input = document.querySelector("#item-price");
  const tax_price = document.querySelector("#add-tax-price");
  const profit = document.querySelector('#profit')
  price_input.addEventListener('input', () => {
    let price = Number(price_input.value)
    let sales = Math.floor(price  * SALES_COMMISSION_PRICE);
    let price_commission = price - sales
    tax_price.textContent =price_commission;
    profit.textContent = sales;
  });
});
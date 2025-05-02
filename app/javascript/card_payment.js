'use strict';

// const number_form = document.querySelector('#number-form');
// const expiry_form = document.querySelector('#expiry-form');
// const cvc_form = document.querySelector('#cvc-form');

// const forms = [number_form, expiry_form, cvc_form];

const input_values = {};

function css_applied(input){
  Object.assign(input.style, {
    width: '100%',
    height: '100%',
    //有効期限のところがなぜかズレるため、下記追加
    display: 'flex',
    border: 'none',
    outline: 'none'
  });
}

function handleClick(e) {
  const form = e.currentTarget;
  const input = form.querySelector('input') || null;

  if (!input) {
    input = document.createElement('input');
    input.type = 'text';
    css_applied(input);
    form.append(input);
  }

  input.focus();

  input.addEventListener('blur', () => {
    input_values[form.id] = input.value;
  },{ once: true }); 
}

window.addEventListener('turbo:render', () => {
  document.querySelectorAll('.input-default').forEach(form => {
    form.addEventListener('click', handleClick);
  });
});

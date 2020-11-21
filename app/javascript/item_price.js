window.addEventListener('load', () => {
  // console.log("非同期投稿を実装");
  const priceInput = document.getElementById("item-price"); // priceInputは、「場所」
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value; // inputValueは、数値(priceInputを、.Valueに！)
    const addTaxDom = document.getElementById("add-tax-price"); // addTaxDomは、あくまで「場所」を示してる。数値ではない！
    const tax = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = tax

    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = Math.floor(inputValue - tax);
  })
});

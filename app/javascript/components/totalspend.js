
const getTotalSpend = () => {
const s = document.getElementById("spend").innerHTML.split(':');
const d = s[1].split('€');
const e = parseInt(d[0]);
console.log(e);

var count = $("#cd-list").children().length;
console.log(count);

var total_spend = e * count;
console.log(total_spend);
const totalSpendHtml = document.getElementById("total-spend");
var newTotalSpendHtml = `Estimated Tonight's Spend: <strong> ${total_spend.toString()}€ </strong>`;
totalSpendHtml.innerHTML = newTotalSpendHtml;
}

export { getTotalSpend };

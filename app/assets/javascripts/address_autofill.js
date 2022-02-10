$(function() {
  return $('#customer_postal_code').jpostal({
    postcode: ['#customer_postal_code'],
    address: {
      '#customer_prefecture_code': '%3',
      '#customer_address_city': '%4',
      '#customer_address_street': '%5%6%7',
    },
  });
});
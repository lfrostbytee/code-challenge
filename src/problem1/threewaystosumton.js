//Assumption is that n is a non-negative integer.

//Recursive
var sum_to_n_a = function(n) {
    if (n == 0) {
        return 0;
    } else {
        return n + sum_to_n_a(n-1);   
    }
};

//Mathemetical Formula of Arithmetic Progression
var sum_to_n_b = function(n) {
    return ((n+1)/2) * (0 + n);
};

//Iterative For Loop
var sum_to_n_c = function(n) {
    var res = 0;
    for (let i = 0; i <= n; i++) {
      res += i;
    }
    return res;
};

for (let i = 0; i < 10; i++) {
    console.log(sum_to_n_a(i));
    console.log(sum_to_n_b(i));
    console.log(sum_to_n_c(i));
}
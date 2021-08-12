class StripeTransactionResponse
 {
    String? message; // message from the response
    bool? success; //state of the processs

    //class constructor
    StripeTransactionResponse({this.message, this.success});
}
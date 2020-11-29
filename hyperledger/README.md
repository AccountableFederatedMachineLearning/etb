This is the chaincode from the asset-transfer-basic example (because it was
easier to adapt the existing example rather than starting from scratch). 
The only interesting transaction is the new transaction `Claim`. All
other transactions are unused. At some point soon, this code should be 
moved into a new contract.

```java
    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public String Claim(final Context ctx, final String claim) {
```    

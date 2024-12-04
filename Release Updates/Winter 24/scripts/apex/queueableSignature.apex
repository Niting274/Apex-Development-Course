//Use the QueueableDuplicateSignature class methods addId(), addInteger(), and addString() to build a unique signature for your queueable job. 
//Use the DuplicateSignature property in the AsyncOptions class to store the queueable job signature. 
//Enqueue your job by using the System.enqueueJob() with the AsyncOptions parameter.

//This example builds the async job signature with UserId and the string MyQueueable.

AsyncOptions options = new AsyncOptions();
options.DuplicateSignature = QueueableDuplicateSignature.Builder()
                                .addId(UserInfo.getUserId())
                                .addString('MyQueueable')
                                .build();
try {
    System.enqueueJob(new MyQueueable(), options);
} catch (DuplicateMessageException ex) {
    //Exception is thrown if there is already an enqueued job with the same signature
    Assert.areEqual('Attempt to enqueue job with duplicate queueable signature',
        ex.getMessage());
}
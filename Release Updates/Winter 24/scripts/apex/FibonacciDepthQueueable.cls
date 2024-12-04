public class FibonacciDepthQueueable implements Queueable {
    private Long nMinus1;
    private Long nMinus2;

    // Public method to initiate Fibonacci calculation
    public static void calculateFibonacciTo(Integer depth) {
        AsyncOptions asyncOptions = new AsyncOptions();
        asyncOptions.maximumQueueableStackDepth = depth;
        System.enqueueJob(new FibonacciDepthQueueable(1, 0), asyncOptions);
    }

    // Constructor with default parameter values
    private FibonacciDepthQueueable(Long nMinus1Param, Long nMinus2Param) {
        this.nMinus1 = nMinus1Param;
        this.nMinus2 = nMinus2Param;
    }

    public void execute(QueueableContext context) {
        Integer currentDepth = AsyncInfo.getCurrentQueueableStackDepth();
        Long fibonacciValue = (currentDepth <= 2) ? 1 : nMinus1 + nMinus2;

        System.debug('Depth: ' + currentDepth + ' Fibonacci Value: ' + fibonacciValue);

        if (currentDepth >= AsyncInfo.getMaximumQueueableStackDepth()) {
            // Insert result at maximum depth
            Fibonacci__c result = new Fibonacci__c(
                Depth__c = currentDepth,
                Result__c = fibonacciValue
            );
            insert result;
        } else {
            // Enqueue the next Fibonacci calculation step
            System.enqueueJob(new FibonacciDepthQueueable(fibonacciValue, nMinus1));
        }
    }
}

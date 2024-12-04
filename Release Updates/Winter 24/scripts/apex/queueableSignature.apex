// Create an instance of AsyncOptions to set properties for Queueable jobs.
AsyncOptions options = new AsyncOptions();

// Build the first DuplicateSignature using the current user's ID and a string identifier.
// This ensures the job is uniquely identifiable based on these components.
options.DuplicateSignature = QueueableDuplicateSignature.Builder()
    .addId(UserInfo.getUserId()) // Add current user's ID.
    .addString('LeadQueueable')  // Add a string identifier for the job type.
    .build();

// Enqueueing the job for the first time with the defined signature.
System.enqueueJob(new LeadQueueable(), options);

// Uncommenting the next line would attempt to enqueue the same job with the same signature.
// Since the signature is identical to the previous one, Salesforce will not enqueue it again.
// System.enqueueJob(new LeadQueueable(), options);

// Update the DuplicateSignature to include an additional integer.
// This changes the signature, allowing the job to be enqueued again, even if the earlier one is still running.
options.DuplicateSignature = QueueableDuplicateSignature.Builder()
    .addId(UserInfo.getUserId()) // Same user ID.
    .addString('LeadQueueable')  // Same string identifier.
    .addInteger(1)              // Add an integer to make the signature unique.
    .build();

// Enqueueing the job again with the updated, unique signature.
// Since the signature is now different, Salesforce allows the job to be enqueued.
System.enqueueJob(new LeadQueueable(), options);
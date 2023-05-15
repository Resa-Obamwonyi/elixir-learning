defmodule KV.BucketTest do
  # note the async: true option, it makes the test case run in parallel with other :async test cases by using multiple cores in our machine
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes values by key", %{bucket: bucket} do
    # put key and value in the bucket, assert that it is there
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3

    # delete value and key in bucket, assert that it is not there
    assert KV.Bucket.delete("milk")
    assert KV.Bucket.get(bucket, "milk") == nil

  end
end

# Notes
# However, :async must only be set if the test case does not rely on or change any global values.
# For example, if the test requires writing to the filesystem or access a database, keep it synchronous (omit the :async option)
# to avoid race conditions between tests
# The setup/1 macro defines a callback that is run before every test, in the same process as the test itself


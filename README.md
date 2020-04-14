# mkdocs-build-action
Plain in-place mkdocs build action to be used in pipelines with a variety of possible deploy targets.

# Usage
This Action literally only invokes a mkdocs build, so your pipeline needs to ensure the mkdocs source is first gathered, and once this action completes you must copy the contents of the destination folder to your intended hosting location.

A typical example would be a GitHub repository with Jekyll source, and publishing the output to an S3 bucket configured for static site hosting.

The pipeline to realize this would look something like the following:
```yaml
jobs:
  mkdocs:
    name: Build and deploy mkdocs site
    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: Build
      uses: jnanadarshan/mkdocs-build-action@v1

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-east-1

    - name: Sync output to S3
      run: |
        aws s3 sync ./site/ s3://my-s3-bucket --delete
```

# References
For more technical details on these steps and associated setup, see:
- [actions/checkout](https://github.com/actions/checkout)
- [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials)
- [Creating encrypted secrets in GitHub](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets)

# A Note on Security
Please be mindful of the third-party actions you trust with your secrets, credentials and content. Without investigation you should assume a third-party action might exfiltrate your content to some secondary location, or modify contents before they are published.

Futhermore, if you rely on versioning that the publisher of an action can control, the action you think you are running could be changed later without your knowledge.

*I suggest you fork this code and create your own Actions to ensure safety.*
... Trust but verify!

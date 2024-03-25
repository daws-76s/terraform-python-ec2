data "archive_file" "ec2_auto_start_zip" {
  type        = "zip"
  source_file = "${path.module}/ec2-auto-start.py"
  output_path = "${path.module}/ec2-auto-start.zip"
}

data "archive_file" "ec2_auto_stop_zip" {
  type        = "zip"
  source_file = "${path.module}/ec2-auto-stop.py"
  output_path = "${path.module}/ec2-auto-stop.zip"
}

resource "aws_lambda_function" "ec2_auto_start" {
  function_name = "EC2AutoStart"
  handler       = "ec2-auto-start.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.12"

  filename         = data.archive_file.ec2_auto_start_zip.output_path
  source_code_hash = data.archive_file.ec2_auto_start_zip.output_base64sha256
  timeout = 60

  depends_on = [aws_iam_policy.lambda_policy]
}

resource "aws_lambda_function" "ec2_auto_stop" {
  function_name = "EC2AutoStop"
  handler       = "ec2-auto-stop.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.12"

  filename         = data.archive_file.ec2_auto_stop_zip.output_path
  source_code_hash = data.archive_file.ec2_auto_stop_zip.output_base64sha256
  timeout = 60

  depends_on = [aws_iam_policy.lambda_policy]
}

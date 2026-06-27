# SNS Topic — sends email notifications
resource "aws_sns_topic" "alerts" {
  name = "aws-monitoring-stack-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# CPU alarm — triggers when average CPU > 80% for 4 minutes
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "aws-monitoring-stack-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "CPU utilisation exceeded 80% for 4 minutes"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = var.instance_id
  }
}

# Status check alarm — triggers if instance fails health check
resource "aws_cloudwatch_metric_alarm" "instance_status" {
  alarm_name          = "aws-monitoring-stack-status-check"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "EC2 instance failed status check"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = var.instance_id
  }
}

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "aws-monitoring-stack-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x    = 0
        y    = 0
        width  = 12
        height = 6
        properties = {
          title   = "CPU Utilisation"
          metrics = [["AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id]]
          period  = 60
          stat    = "Average"
          view    = "timeSeries"
          region  = "eu-west-2"
        }
      },
      {
        type = "metric"
        x    = 12
        y    = 0
        width  = 12
        height = 6
        properties = {
          title   = "Status Check Failed"
          metrics = [["AWS/EC2", "StatusCheckFailed", "InstanceId", var.instance_id]]
          period  = 60
          stat    = "Maximum"
          view    = "timeSeries"
          region  = "eu-west-2"
        }
      }
    ]
  })
}
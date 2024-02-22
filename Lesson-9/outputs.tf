output "created_iam_users_all" {
  value = aws_iam_user.users
}
output "id_users" {
  value = aws_iam_user.users[*].id
}
output "created_iam_users_custom" {
  value = [
    for user in aws_iam_user.users :
          "Username ${user.name} has id ${user.id}"
  ]
}
output "map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id
  }
}
output "custom_if_length" {
  value = [
    for x in aws_iam_user.users :
    x.name
    if length(x.name) == 4
  ]
}
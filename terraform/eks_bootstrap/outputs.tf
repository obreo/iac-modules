output "ecr_registry_ids" {
    value       = [for repo in aws_ecr_repository.ecr : repo.registry_id]
    description = "The registry IDs where ECR the repositories were created."
}
variable "team_name" {
  description = "Team name prefix"
  default     = "team1"
}

variable "key_name" {
  description = "EC2 Key pair name"
  type        = string
  default     = "Bugbusters"
}
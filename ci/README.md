# Jenkins Pipeline Notes

- The declarative pipeline lives in `ci/Jenkinsfile`.
- Expected Jenkins credentials:
  - `registry-creds`: username/password for the local registry created by Terraform.
  - `sonarqube-token`: secret text generated in SonarQube for the service account.
  - `ansible-vault-password`: secret text that unlocks `group_vars/all/vault.yml`.
  - `kubeconfig-local`: file credential containing the Kind kubeconfig from `infra/terraform/kubeconfig`.
- Tools required on the agent: Docker, Terraform, Trivy, Conftest, Sonar Scanner, Ansible (prepared by the Ansible `container_runtime` role).
- The pipeline stops for manual approval before applying Terraform changes.
- Reports produced:
  - Dependency-Check XML in `reports/dependency-check`.
  - Trivy HTML report in `reports/trivy`.
  - OWASP ZAP XML report in `reports/zap`.
- To run the pipeline locally with Jenkins, ensure the Kind cluster and registry are up by executing `terraform apply` first.


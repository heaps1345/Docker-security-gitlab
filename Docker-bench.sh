stages:
  - audit

audit-docker-security:
  stage: audit
  image: docker:latest
  services:
    - docker:dind
  script:
    - apk add --no-cache bash git
    - git clone https://github.com/docker/docker-bench-security.git
    - cd docker-bench-security
    - ./docker-bench-security.sh > output.log
    - if grep -q "WARN" output.log; then echo "Warnings found in docker-bench-security scan!"; cat output.log; exit 1; else echo "No warnings found."; fi

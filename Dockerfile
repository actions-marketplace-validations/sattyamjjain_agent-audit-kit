# Pin to specific digest for supply chain security
FROM python:3.14-slim@sha256:bc389f7dfcb21413e72a28f491985326994795e34d2b86c8ae2f417b4e7818aa AS base

LABEL maintainer="AgentAuditKit"
LABEL org.opencontainers.image.source="https://github.com/sattyamjjain/agent-audit-kit"
LABEL org.opencontainers.image.description="Security scanner for MCP-connected AI agent pipelines"

COPY . /app
WORKDIR /app
RUN pip install --no-cache-dir .

# Create non-root user for security
RUN groupadd -r scanner && useradd -r -g scanner -d /home/scanner -s /sbin/nologin scanner
RUN mkdir -p /home/scanner && chown -R scanner:scanner /home/scanner

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER scanner

ENTRYPOINT ["/entrypoint.sh"]

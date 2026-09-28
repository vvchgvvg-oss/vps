FROM python:3.11-slim
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=5000 \
    PIP_NO_CACHE_DIR=1
RUN groupadd --system --gid 10001 paneluser && useradd --system --uid 10001 --gid paneluser --home-dir /app --shell /usr/sbin/nologin paneluser
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY main.py sandbox_runner.py app.py ./
RUN mkdir -p /app/panel_data/users_data /app/panel_data/backups /app/panel_data/temp /app/panel_data/public_static \
    && chown -R paneluser:paneluser /app \
    && chmod 700 /app/panel_data /app/panel_data/users_data /app/panel_data/backups /app/panel_data/temp
USER 10001:10001
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 CMD python -c "import os,urllib.request; urllib.request.urlopen('http://127.0.0.1:'+os.environ.get('PORT','5000')+'/login', timeout=3)" || exit 1
CMD ["python", "main.py"]

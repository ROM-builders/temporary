load("cirrus", "env", "http")

def on_task_failed(ctx):
    url = env.get("SLACK_WEBHOOK_URL")
    if not url:
        return

    message = {
        "text": "https://cirrus-ci.com/task/{} failed!".format(ctx.payload.data.task.id)
    }

    http.post(url, json_body=message)

load("cirrus", "env", "http")

def on_task_failed(ctx):
    url = env.get("https://hooks.slack.com/services/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")
    if not url:
        return

    message = {
        "text": "https://cirrus-ci.com/task/{} failed!".format(ctx.payload.data.task.id)
    }

    http.post(url, json_body=message)

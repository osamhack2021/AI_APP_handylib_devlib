from Alternating_Least_Squares import predict
from apscheduler.schedulers.background import BackgroundScheduler

def job():
    file_path = '/var/www/python_flask/main/models/'  # 서버 폴더경로 맞춰서 설정
    users_file_name = "API_test_users.csv"
    updater(file_path, users_file_name)

def updater(file_path, users_file_name):
    pred_file_name = "rec_pred_score_1.csv"
    predict(file_path, users_file_name, pred_file_name)

sched = BackgroundScheduler()
sched.start()
sched.add_job(job, 'cron', hour='*/1', id="update pred_score")

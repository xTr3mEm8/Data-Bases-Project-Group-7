--Ana Radut

--this query counts the number of reminders each user has and groups them by category (SMS or email)
SELECT u.username, 
    COUNT(er.reminder_id) AS email_count, 
    COUNT(sr.reminder_id) AS sms_count
FROM Users u
JOIN Tasks t ON u.user_id = t.user_id
LEFT JOIN Reminders r ON t.task_id = r.task_id
LEFT JOIN EmailReminders er ON r.reminder_id = er.reminder_id
LEFT JOIN SMSReminders sr ON r.reminder_id = sr.reminder_id
GROUP BY u.username;

--this query lists all users who have both a personal task and a work task and counts how many tasks they have in those categories
SELECT u.username, 
    COUNT(DISTINCT pt.personal_task_id) AS personal_task_count, 
    COUNT(DISTINCT wt.work_task_id) AS work_task_count
FROM Users u
LEFT JOIN Tasks t ON u.user_id = t.user_id
LEFT JOIN Personal_Task pt ON t.task_id = pt.personal_task_id
LEFT JOIN Work_Task wt ON t.task_id = wt.work_task_id
GROUP BY u.username
HAVING personal_task_count > 0 AND work_task_count > 0;

--this query lists all users who have tasks in progress with the number of reminders they have
SELECT u.username, t.title, t.deadline, COUNT(r.reminder_id) AS reminder_count
FROM Users u
JOIN Tasks t ON u.user_id = t.user_id
JOIN TaskStatus ts ON t.status_id = ts.status_id
LEFT JOIN Reminders r ON t.task_id = r.task_id
WHERE ts.status_name = 'in-progress'
GROUP BY u.username, t.title, t.deadline;

--Cristian Ionut Malus

--For each user, retrieve all their tasks, the reminder times, and count how many reminders are associated with each task.
SELECT u.username, t.title, t.description, COUNT(r.reminder_id) AS reminder_count
FROM Users u
JOIN Tasks t ON u.user_id = t.user_id
LEFT JOIN Reminders r ON t.task_id = r.task_id
GROUP BY u.username, t.title;

--Retrieve all users who have high-priority tasks with at least two reminders set.
SELECT u.username, t.title, COUNT(r.reminder_id) AS reminder_count
FROM Users u
JOIN Tasks t ON u.user_id = t.user_id
JOIN Reminders r ON t.task_id = r.task_id
WHERE t.priority = 'High'
GROUP BY u.username, t.title
HAVING COUNT(r.reminder_id) >= 2;

--Retrive the number of task per user grouped by task type (personal or work)
SELECT u.username, 
       CASE 
           WHEN pt.personal_task_id IS NOT NULL THEN 'Personal Task'
           WHEN wt.work_task_id IS NOT NULL THEN 'Work Task'
       END AS task_type, 
       COUNT(t.task_id) AS task_count
FROM Users u
JOIN Tasks t ON u.user_id = t.user_id
LEFT JOIN Personal_Task pt ON t.task_id = pt.personal_task_id
LEFT JOIN Work_Task wt ON t.task_id = wt.work_task_id
GROUP BY u.username, task_type;

--Paul Adrian Mandravel

--Retrieve users with overdue tasks and the number of reminders associated with each:
SELECT u.username, t.title, t.deadline, COUNT(r.reminder_id) AS reminder_count
FROM Users u
JOIN Tasks t ON u.user_id = t.user_id
LEFT JOIN Reminders r ON t.task_id = r.task_id
WHERE t.deadline < NOW()
GROUP BY u.username, t.title, t.deadline;

--List all users who have completed tasks with more than one reminder set:
SELECT u.username, t.title, COUNT(r.reminder_id) AS reminder_count
FROM Users u
JOIN Tasks t ON u.user_id = t.user_id
LEFT JOIN Reminders r ON t.task_id = r.task_id
JOIN TaskStatus ts ON t.status_id = ts.status_id
WHERE ts.status_name = 'completed'
GROUP BY u.username, t.title
HAVING COUNT(r.reminder_id) > 1;

--Retrieve information about users and their tasks, specifically focusing on tasks that have a priority of 'Medium' or 'Low'. The query also counts how many reminders are associated with each task.
SELECT u.username, t.title, t.priority, COUNT(r.reminder_id) AS reminder_count
FROM Users u
JOIN Tasks t ON u.user_id = t.user_id
LEFT JOIN Reminders r ON t.task_id = r.task_id
WHERE t.priority IN (1, 2)  -- Assuming 1 = Low and 2 = Medium
GROUP BY u.username, t.title, t.priority;
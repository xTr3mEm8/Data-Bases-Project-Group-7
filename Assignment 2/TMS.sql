CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Admin (
    user_id INT PRIMARY KEY,
    admin_permissions VARCHAR(255),
    last_login TIMESTAMP,
    access_level INT,
    department VARCHAR(100),
    actions_log TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE RegularUser (
    user_id INT PRIMARY KEY,
    subscription_status VARCHAR(50),
    user_preferences TEXT,
    task_limit INT DEFAULT 50,
    account_status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE TaskStatus (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(100)
);

CREATE TABLE Tasks (
    task_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    deadline DATE,
    priority INT,
    status_id INT,
    user_id INT,
    FOREIGN KEY (status_id) REFERENCES TaskStatus(status_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Personal_Task (
    personal_task_id INT PRIMARY KEY AUTO_INCREMENT,
    personal_notes TEXT,
    category VARCHAR(200),
    FOREIGN KEY (personal_task_id) REFERENCES Tasks(task_id)
);

CREATE TABLE Work_Task (
    work_task_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(200),
    deadline_extension DATE,
    FOREIGN KEY (work_task_id) REFERENCES Tasks(task_id)
);

CREATE TABLE Reminders (
    reminder_id INT PRIMARY KEY AUTO_INCREMENT,
    reminder_time BIGINT,
    task_id INT,
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id)
);

CREATE TABLE EmailReminders (
    reminder_id INT PRIMARY KEY AUTO_INCREMENT,
    email_address NVARCHAR(320),
    FOREIGN KEY (reminder_id) REFERENCES Reminders(reminder_id)
);

CREATE TABLE SMSReminders (
    reminder_id INT PRIMARY KEY AUTO_INCREMENT,
    phone_number VARCHAR(45),
    FOREIGN KEY (reminder_id) REFERENCES Reminders(reminder_id)
);

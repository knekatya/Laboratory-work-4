CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    location_name VARCHAR(100) NOT NULL,
    CONSTRAINT chk_users_full_name
    CHECK (REGEXP_LIKE(full_name, '^[A-Za-zА-Яа-яІіЇїЄє'' -]{2,100}$')),
    CONSTRAINT chk_users_location_name
    CHECK (REGEXP_LIKE(location_name, '^[A-Za-zА-Яа-яІіЇїЄє0-9'' -]{2,100}$'))
)

CREATE TABLE budgets (
    budget_id NUMBER PRIMARY KEY,
    user_id NUMBER NOT NULL,
    balance_amount NUMBER NOT NULL,
    structure_description VARCHAR(200) NOT NULL,
    CONSTRAINT fk_budgets_user
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT chk_budgets_balance_amount
    CHECK (balance_amount >= 0),
    CONSTRAINT chk_budgets_structure_description
    CHECK (LENGTH(structure_description) >= 2)
);

CREATE TABLE incomes (
    income_id NUMBER PRIMARY KEY,
    budget_id NUMBER NOT NULL,
    amount NUMBER NOT NULL,
    income_date DATE NOT NULL,
    source_name VARCHAR(100) NOT NULL,
    CONSTRAINT fk_incomes_budget
    FOREIGN KEY (budget_id) REFERENCES budgets (budget_id),
    CONSTRAINT chk_incomes_amount
    CHECK (amount > 0),
    CONSTRAINT chk_incomes_source_name
    CHECK (REGEXP_LIKE(source_name, '^[A-Za-zА-Яа-яІіЇїЄє0-9'' -]{2,100}$'))
);

CREATE TABLE expenses (
    expense_id NUMBER PRIMARY KEY,
    budget_id NUMBER NOT NULL,
    amount NUMBER NOT NULL,
    expense_date DATE NOT NULL,
    category_name VARCHAR(100) NOT NULL,
    CONSTRAINT fk_expenses_budget
    FOREIGN KEY (budget_id) REFERENCES budgets (budget_id),
    CONSTRAINT chk_expenses_amount
    CHECK (amount > 0),
    CONSTRAINT chk_expenses_category_name
    CHECK (REGEXP_LIKE(category_name, '^[A-Za-zА-Яа-яІіЇїЄє0-9'' -]{2,100}$'))
);

CREATE TABLE air_quality (
    air_quality_id NUMBER PRIMARY KEY,
    user_id NUMBER NOT NULL,
    location_name VARCHAR(100) NOT NULL,
    quality_level VARCHAR(50) NOT NULL,
    aqi_value NUMBER NOT NULL,
    measurement_date DATE NOT NULL,
    CONSTRAINT fk_air_quality_user
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT chk_air_quality_location_name
    CHECK (REGEXP_LIKE(location_name, '^[A-Za-zА-Яа-яІіЇїЄє0-9'' -]{2,100}$')),
    CONSTRAINT chk_air_quality_aqi_value
    CHECK (aqi_value >= 0 AND aqi_value <= 500),
    CONSTRAINT chk_air_quality_quality_level
    CHECK (LENGTH(quality_level) >= 2)
);

CREATE TABLE forecasts (
    forecast_id NUMBER PRIMARY KEY,
    air_quality_id NUMBER NOT NULL,
    forecast_date DATE NOT NULL,
    predicted_level VARCHAR(50) NOT NULL,
    predicted_aqi NUMBER NOT NULL,
    CONSTRAINT fk_forecasts_air_quality
    FOREIGN KEY (air_quality_id) REFERENCES air_quality (air_quality_id),
    CONSTRAINT chk_forecasts_predicted_aqi
    CHECK (predicted_aqi >= 0 AND predicted_aqi <= 500),
    CONSTRAINT chk_forecasts_predicted_level
    CHECK (LENGTH(predicted_level) >= 2)
);

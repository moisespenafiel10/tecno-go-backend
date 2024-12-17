PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS professional_careers;

CREATE TABLE
  professional_careers (id TEXT PRIMARY KEY, name TEXT UNIQUE NOT NULL);

DROP TABLE IF EXISTS users;

CREATE TABLE
  users (
    uuid TEXT PRIMARY KEY,
    first_names TEXT,
    last_names TEXT,
    email TEXT UNIQUE,
    phone_number TEXT,
    professional_career TEXT REFERENCES professional_careers (id),
    semester TEXT,
    birth_date TEXT,
    dni TEXT UNIQUE,
    url_image TEXT,
    blurhash TEXT
  );

DROP TABLE IF EXISTS procedure_types;

CREATE TABLE
  procedure_types (id TEXT PRIMARY KEY NOT NULL, name TEXT);

DROP TABLE IF EXISTS efsrt_modules;

CREATE TABLE
  efsrt_modules (
    module_id INTEGER PRIMARY KEY AUTOINCREMENT,
    placeOfExecution TEXT,
    startDate INTEGER,
    endDate INTEGER,
    supervisor TEXT REFERENCES users (uuid)
  );

DROP TABLE IF EXISTS procedures;

CREATE TABLE
  procedures (
    uuid TEXT PRIMARY KEY,
    user_uuid TEXT REFERENCES users (uuid),
    procedure_type TEXT REFERENCES procedure_types (id),
    submission_date INTEGER NOT NULL,
    is_completed INTEGER DEFAULT (0),
    additional_data TEXT
  );

DROP TABLE IF EXISTS procedures_completed;

CREATE TABLE
  procedures_completed (
    uuid TEXT PRIMARY KEY,
    user_uuid TEXT REFERENCES users (uuid),
    procedure_type TEXT REFERENCES procedure_types (id),
    submission_date INTEGER,
    completed_date INTEGER,
    download_base_url TEXT,
    additional_data TEXT,
    file_extension TEXT
  );

DROP TABLE IF EXISTS efsrt;

CREATE TABLE
  efsrt (
    user_uuid TEXT REFERENCES users (uuid) PRIMARY KEY,
    module_active INTEGER,
    progress_percentage INTEGER,
    module_1_procedure_uuid INTEGER REFERENCES efsrt_modules (module_id),
    module_2_procedure_uuid INTEGER REFERENCES efsrt_modules (module_id),
    module_3_procedure_uuid INTEGER REFERENCES efsrt_modules (module_id)
  );

-- Inserción de datos (en el orden que respeta las dependencias)
INSERT INTO
  professional_careers (id, name)
VALUES
  ('JMA-PA', 'Producción Agropecuaria'),
  ('JMA-CI', 'Computación e Informática'),
  ('JMA-ET', 'Enfermería Técnica'),
  ('JMA-MA', 'Mecánica Automotriz');

INSERT INTO
  users (
    uuid,
    first_names,
    last_names,
    email,
    phone_number,
    professional_career,
    semester,
    birth_date,
    dni,
    url_image,
    blurhash
  )
VALUES
  (
    '04937660-6e77-42e2-81f7-cc5c76bf68bd',
    'Name',
    'Last Names',
    'ejemplo@gmail.com',
    '999888877',
    'JMA-CI',
    'VII',
    '2000-01-01',
    '10000000',
    'https://i.ibb.co/C01SdWY/f3c88c1059a2.jpg',
    'KCJS00wF~Bg7?GO?R=yE$c'
  ),
  (
    '2',
    'Pepe',
    'Lucho',
    'luchoPP@hotmail.com',
    '984561354',
    'JMA-ET',
    'I',
    '10-30-2000',
    '46598788',
    NULL,
    NULL
  );

INSERT INTO
  procedure_types (id, name)
VALUES
  ('PROCEDURE-CDP', 'Carta de Presentacion'),
  ('PROCEDURE-CDE', 'Certificado de Estudios'),
  ('PROCEDURE-CAWS', 'Certificado AWS');

INSERT INTO
  efsrt_modules (
    module_id,
    placeOfExecution,
    startDate,
    endDate,
    supervisor
  )
VALUES
  (
    56,
    'Ugel - Lucanas',
    1732581479000,
    1732685879000,
    NULL
  ),
  (
    57,
    'MPLP - Ayacucho',
    1730782800000,
    1733425949000,
    NULL
  );

INSERT INTO
  procedures (
    uuid,
    user_uuid,
    procedure_type,
    submission_date,
    is_completed,
    additional_data
  )
VALUES
  (
    'b3492ce1-cd36-4f35-8785-334668fabd70',
    '04937660-6e77-42e2-81f7-cc5c76bf68bd',
    'PROCEDURE-CDP',
    1732129393300,
    0,
    '{"placeOfExecution":"UGEL","startDate":1731697140000}'
  ),
  (
    'f293d9c5-1359-4580-918e-e88fcf3f4c72',
    '04937660-6e77-42e2-81f7-cc5c76bf68bd',
    'PROCEDURE-CAWS',
    1732130440412,
    0,
    '{"startDate":1731265140000,"endDate":"Secundaria","some":"not reason"}'
  ),
  (
    '6ca82b36-e6ad-4c05-b6a8-2ecd713ad817',
    '04937660-6e77-42e2-81f7-cc5c76bf68bd',
    'PROCEDURE-CDE',
    1732241320523,
    0,
    NULL
  );

INSERT INTO
  procedures_completed (
    uuid,
    user_uuid,
    procedure_type,
    submission_date,
    completed_date,
    download_base_url,
    additional_data,
    file_extension
  )
VALUES
  (
    'b3492ce1-cd36-4f35-8785-334668fabd70',
    '04937660-6e77-42e2-81f7-cc5c76bf68bd',
    'PROCEDURE-CDP',
    1732129393300,
    1732129319300,
    'https://pub-2b8d940d2847481eb0bb7f70415fefb7.r2.dev/procedures_completed/',
    '{"placeOfExecution":"UGEL","startDate":1731697140000}',
    'pdf'
  ),
  (
    '705486ba-1f2e-4e5b-af3d-85a45b842679',
    '04937660-6e77-42e2-81f7-cc5c76bf68bd',
    'PROCEDURE-CDE',
    1732129393300,
    1732129319300,
    'https://pub-2b8d940d2847481eb0bb7f70415fefb7.r2.dev/procedures_completed/',
    NULL,
    'pdf'
  ),
  (
    'a204b9ef-0b93-4cc5-88ac-6863602c9108',
    '04937660-6e77-42e2-81f7-cc5c76bf68bd',
    'PROCEDURE-CAWS',
    1732129393300,
    1732129393300,
    NULL,
    NULL,
    NULL
  );

INSERT INTO
  efsrt (
    user_uuid,
    module_active,
    progress_percentage,
    module_1_procedure_uuid,
    module_2_procedure_uuid,
    module_3_procedure_uuid
  )
VALUES
  (
    '04937660-6e77-42e2-81f7-cc5c76bf68bd',
    2,
    10,
    56,
    57,
    NULL
  );

PRAGMA foreign_keys = ON;
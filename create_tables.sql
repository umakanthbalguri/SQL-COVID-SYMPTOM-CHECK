/*  Creating Umember table */
CREATE TABLE umember (
    unumber          NUMBER(8),
    mname            VARCHAR2(50) NOT NULL,
    mrole            VARCHAR2(15) NOT NULL,
    memail           VARCHAR2(50) NOT NULL UNIQUE,
    mailing_address  VARCHAR2(250) NOT NULL,
    joining_date     DATE NOT NULL,
    base_campus      VARCHAR2(20) NOT NULL CHECK ( base_campus IN ('Tampa','Sarasota','St. Petersburg' )),
    CONSTRAINT pk_umember PRIMARY KEY ( unumber )
);

/*  Creating visit table */
CREATE TABLE visit(
    record_id        NUMBER(10),
    record_timestamp      TIMESTAMP NOT NULL,   
    unumber          NUMBER(8),
    Campus_Visiting_YN CHAR(1) NOT NULL CHECK ( Campus_Visiting_YN = 'Y'
                                                   OR Campus_Visiting_YN = 'N' ),
    CONSTRAINT pk_record_id PRIMARY KEY ( record_id ),
FOREIGN KEY (unumber) REFERENCES umember(unumber)
 );


/*  Creating campus table */
CREATE TABLE campus (
    campus_id       NUMBER(3),
    campus          VARCHAR2(20) NOT NULL,
    campus_address  VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_campus_id PRIMARY KEY ( campus_id )
);

/*  Creating building table */
CREATE TABLE building (
    building_code  CHAR(3),
    building_name  VARCHAR2(50) NOT NULL,
    campus_id      NUMBER(3) NOT NULL,
    CONSTRAINT pk_building_code PRIMARY KEY ( building_code ),
    FOREIGN KEY ( campus_id )
        REFERENCES campus ( campus_id )
);

/*  Creating classroom table */
CREATE TABLE classroom (
    classroom_id        NUMBER(4),
    classroom_name      VARCHAR2(50) NOT NULL,
    building_code       CHAR(3),
    classroom_capacity  NUMBER(5),
    CONSTRAINT pk_cid_bc_fk PRIMARY KEY ( classroom_id,
                                          building_code ),
    FOREIGN KEY ( building_code )
        REFERENCES building ( building_code )
);

/*  Creating visit_location table */
CREATE TABLE visit_location (
    record_id      NUMBER(10),
    campus_id      NUMBER(3),
    building_code  CHAR(3),
    classroom_id   NUMBER(4),
    CONSTRAINT pk_record_id_bc_cid PRIMARY KEY ( record_id,
                                                 building_code,
                                                 classroom_id ),
    FOREIGN KEY ( record_id )
        REFERENCES visit ( record_id ),
    FOREIGN KEY ( classroom_id,
                  building_code )
        REFERENCES classroom ( classroom_id,
                               building_code ),
    FOREIGN KEY ( campus_id )
        REFERENCES campus ( campus_id )
);

 /*  Creating cdeclaration table */
CREATE TABLE cdeclaration (
    record_id              NUMBER(10),
    contact_with_positive  CHAR(1) NOT NULL CHECK ( contact_with_positive = 'Y'
                                                   OR contact_with_positive = 'N' ),
    covid_tested           CHAR(1) NOT NULL CHECK ( covid_tested = 'Y'
                                          OR covid_tested = 'N' ),
    physically_fine        CHAR(1) NOT NULL CHECK ( physically_fine = 'Y'
                                             OR physically_fine = 'N' ),
    CONSTRAINT pk_record_id_cdeclaration PRIMARY KEY ( record_id ),
    FOREIGN KEY ( record_id )
        REFERENCES visit ( record_id )
);

  /*  Creating cexternaltest table */
CREATE TABLE cexternaltest (
    record_id      NUMBER(10),
    external_test  CHAR(1) NOT NULL CHECK ( external_test = 'Y'
                                           OR external_test = 'N' ),
    CONSTRAINT pk_record_id_cexternaltest PRIMARY KEY ( record_id ),
    FOREIGN KEY ( record_id )
        REFERENCES visit ( record_id )
);

   /*  Creating ctestlocation table */
CREATE TABLE ctestlocation (
    record_id      NUMBER(10),
    test_location  VARCHAR2(250) NOT NULL,
    CONSTRAINT pk_record_id_ctestlocation PRIMARY KEY ( record_id ),
    FOREIGN KEY ( record_id )
        REFERENCES visit ( record_id )
);

    /*  Creating csdeclaration table */
CREATE TABLE csdeclaration (
    record_id            NUMBER(10),
    symptom_temperature  CHAR(1) NOT NULL CHECK ( symptom_temperature = 'Y'
                                                 OR symptom_temperature = 'N' ),
    symptom_cough        CHAR(1) NOT NULL CHECK ( symptom_cough = 'Y'
                                           OR symptom_cough = 'N' ),
    symptom_breath       CHAR(1) NOT NULL CHECK ( symptom_breath = 'Y'
                                            OR symptom_breath = 'N' ),
    symptom_headache     CHAR(1) NOT NULL CHECK ( symptom_headache = 'Y'
                                              OR symptom_headache = 'N' ),
    symptom_fatigue      CHAR(1) NOT NULL CHECK ( symptom_fatigue = 'Y'
                                             OR symptom_fatigue = 'N' ),
    symptom_nausea       CHAR(1) NOT NULL CHECK ( symptom_nausea = 'Y'
                                            OR symptom_nausea = 'N' ),
    symptom_stomachache  CHAR(1) NOT NULL CHECK ( symptom_stomachache = 'Y'
                                                 OR symptom_stomachache = 'N' ),
    symptom_dizziness    CHAR(1) NOT NULL CHECK ( symptom_dizziness = 'Y'
                                               OR symptom_dizziness = 'N' ),
    symptom_sorethroat   CHAR(1) NOT NULL CHECK ( symptom_sorethroat = 'Y'
                                                OR symptom_sorethroat = 'N' ),
    symptom_lossofsmell  CHAR(1) NOT NULL CHECK ( symptom_lossofsmell = 'Y'
                                                 OR symptom_lossofsmell = 'N' ),
    CONSTRAINT pk_record_id_csdeclaration PRIMARY KEY ( record_id ),
    FOREIGN KEY ( record_id )
        REFERENCES visit ( record_id )
);

   /*  Creating pass table */
CREATE TABLE pass (
    record_id   NUMBER(10),
    pass_issue  CHAR(1) NOT NULL CHECK ( pass_issue = 'Y'
                                        OR pass_issue = 'N' ),
    CONSTRAINT pk_record_idpass_pass PRIMARY KEY ( record_id ),
    FOREIGN KEY ( record_id )
        REFERENCES visit ( record_id )
);

    /*  Creating pass_qrcode table */
CREATE TABLE pass_qrcode (
    record_id    NUMBER(10),
    pass_qrcode  VARCHAR2(250) NOT NULL UNIQUE,
    CONSTRAINT pk_record_id_pass_qrcode PRIMARY KEY ( record_id ),
    FOREIGN KEY ( record_id )
        REFERENCES visit ( record_id )
);
DROP PROCEDURE IF EXISTS script;

DELIMITER //

CREATE PROCEDURE `script` ()
BEGIN
    DECLARE v_cursor_not_found INT DEFAULT FALSE;
    DECLARE v_country_acronym, v_state_acronym CHAR(2);
    DECLARE v_city_name_uri, v_category_name, v_tag_name VARCHAR(1000);
    DECLARE v_record_counter, v_record_added_counter, v_country_id, v_state_id, v_city_id, v_category_id, v_category_id_exists, v_tag_id_exists, v_ad_id_max, v_ad_category_id_max, v_phone_id_max, v_ad_phone_id_max, v_category_id_max, v_tag_id_max, v_ad_tag_id_max INT;
    DECLARE cursorAdMax CURSOR FOR SELECT COALESCE(MAX(id), 0) FROM AD_TBL;
    DECLARE cursorAdCategoryMax CURSOR FOR SELECT COALESCE(MAX(id), 0) FROM AD_CATEGORY_TBL;
    DECLARE cursorPhoneMax CURSOR FOR SELECT COALESCE(MAX(id), 0) FROM PHONE_TBL;
    DECLARE cursorAdPhoneMax CURSOR FOR SELECT COALESCE(MAX(id), 0) FROM AD_PHONE_TBL;
    DECLARE cursorCategoryMax CURSOR FOR SELECT COALESCE(MAX(id), 0) FROM CATEGORY_TBL;
    DECLARE cursorTagMax CURSOR FOR SELECT COALESCE(MAX(id), 0) FROM TAG_TBL;
    DECLARE cursorAdTagMax CURSOR FOR SELECT COALESCE(MAX(id), 0) FROM AD_TAG_TBL;
    DECLARE cursorCountry CURSOR FOR SELECT id FROM COUNTRY_TBL WHERE UPPER(acronym) = UPPER(v_country_acronym);
    DECLARE cursorState CURSOR FOR SELECT id FROM STATE_TBL WHERE country_id = v_country_id AND UPPER(acronym) = UPPER(v_state_acronym);
    DECLARE cursorCity CURSOR FOR SELECT id FROM CITY_TBL WHERE state_id = v_state_id AND UPPER(name_uri) = UPPER(v_city_name_uri);
    DECLARE cursorCategory CURSOR FOR SELECT id FROM CATEGORY_TBL WHERE UPPER(name) = UPPER(v_category_name);
    DECLARE cursorTag CURSOR FOR SELECT id FROM TAG_TBL WHERE UPPER(name) = UPPER(v_tag_name);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_cursor_not_found = TRUE;
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Alimentos Kunz', 'alimentos-kunz', 'Centro', 'Caminho Morro do Pedro', '109', null, -29.52863, -51.11367, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691473', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'BISCOITOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'BISCOITOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Restaurante Paradouro', 'restaurante-paradouro', 'Centro', 'Rod. Estrada Paradouro', '65', null, -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Comida Variada';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135695040', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'RESTAURANTES FONDUE ALMOCO COLONIAL';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'RESTAURANTES FONDUE ALMOCO COLONIAL', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'El Paradiso', 'el-paradiso', 'Centro', 'Vrs 833 Km 05', '440', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Restaurantes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135695040', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Chega Mais', 'chega-mais', 'Distrito Santa Rosa', 'Rua Vinte E Cinco de Julho', 's/n', null, -29.54066, -51.07781, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Restaurantes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Restaurante El Paradiso', 'restaurante-el-paradiso', 'Centro', 'Rua S. José Herval', 'S/N', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Comida Variada';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135695040', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'RESTAURANTES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'RESTAURANTES', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Metalúrgica Reuter', 'metalurgica-reuter', 'Centro', 'Rodovia Br-116', '14803', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Metalurgia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691077', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'METALURGIA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'METALURGIA', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Armazém do Sofá Móveis e Decorações', 'armazem-do-sofa-moveis-e-decoracoes', 'Centro', 'Rodovia Br-116', 's/n', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Móveis';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692110', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'MOVEIS  LOJAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MOVEIS  LOJAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Escola Municipal Edvino Bervian', 'escola-municipal-edvino-bervian', 'Centro', 'Rua Arthur Alfredo Hoffmeister', null, null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Escolas Públicas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691533', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ESCOLAS PUBLICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ESCOLAS PUBLICAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Indústria de Esquadrias Buttenbender', 'industria-de-esquadrias-buttenbender', 'Centro', 'Rodovia Br-116', 's/n km 210 km 210 0', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Portas e Janelas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691299', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ESQUADRIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ESQUADRIAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Metalurgica Weber', 'metalurgica-weber', 'Vila Ferraria', 'Rua Pedro Tome', null, '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Metalurgia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bar e Lancheria Central', 'bar-e-lancheria-central', 'Centro', 'Walachai', '0', null, -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555191934220', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'LANCHERIA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LANCHERIA', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Cpm da Escola Estadual de 1º Grau João Wagner', 'cpm-da-escola-estadual-de-1º-grau-joao-wagner', 'Centro', 'Rua Anita Garibaldi', 's/n', null, -29.54015, -51.07877, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Escolas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691344', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ESCOLAS PUBLICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ESCOLAS PUBLICAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Dlc Móveis', 'dlc-moveis', 'Centro', 'Rua Pedro Boufler', '65', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Móveis';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135672510', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'MOVEIS  LOJAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MOVEIS  LOJAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Scheid Materiais de Construção', 'scheid-materiais-de-construcao', 'Centro', 'Rua Travessão', '315', null, -29.5391, -51.08293, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Materiais de Construção';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691244', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'MATERIAIS DE CONSTRUCAO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MATERIAIS DE CONSTRUCAO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Escolar do Colegio Estadual Conego Afonso Scherer', 'caixa-escolar-do-colegio-estadual-conego-afonso-scherer', 'Centro', 'Rua Professor Laurindo Vier', '253', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Escolas Públicas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671066', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ESCOLAS PUBLICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ESCOLAS PUBLICAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Irmãos Zimmer', 'irmaos-zimmer', 'Centro', 'Rua Beno Closs', '2065', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Mecânicas e Oficinas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135672001', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'OFICINAS MECANICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'OFICINAS MECANICAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Desentupidora e Limpa Fossa Ajax - São Jorge', 'desentupidora-e-limpa-fossa-ajax---sao-jorge', 'São José', 'Rua Guaiba', '1129', null, -29.5071, -51.08306, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Desentupidoras';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135254072', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'DESENTUPIMENTO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'DESENTUPIMENTO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Prefeitura Municipal de Santa Maria do Herval', 'prefeitura-municipal-de-santa-maria-do-herval', 'Centro', 'Rua Beno Closs', '88', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Prefeituras Municipais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671001', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'PREFEITURAS MUNICIPAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'PREFEITURAS MUNICIPAIS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Agência dos Correios - Ac Morro Reuter - Agencia Correio', 'agencia-dos-correios---ac-morro-reuter---agencia-correio', 'Centro', 'Rua Vinte E Um de Abril', '72', '93990970', -29.54059, -51.08257, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Correios';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691444', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691444', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 2, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CORREIOS TELEGRAFOS AGENCIA CORREIO POSTAL TELEGRAMA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CORREIOS TELEGRAFOS AGENCIA CORREIO POSTAL TELEGRAMA', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ect-Empresa Brasileira de Correios e Telégrafos', 'ect-empresa-brasileira-de-correios-e-telegrafos', 'Centro', 'Rua Vinte E Um de Abril', '72', null, -29.54059, -51.08257, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Correios';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691444', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CORREIOS E TELEGRAFOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CORREIOS E TELEGRAFOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Soc Cultural Benef Herval', 'soc-cultural-benef-herval', 'Distrito Santa Rosa', 'Rua Vinte E Cinco de Julho', 's/n', null, -29.54066, -51.07781, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Restaurantes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Estrada Padre Eterno Ilges 355', 'estrada-padre-eterno-ilges-355', 'Centro', 'Rua Pedro Boufler 19', '0', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Correios';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555199498091', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Pousada Dimabel', 'pousada-dimabel', 'Centro', 'Rua Almiro Closs', null, '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Pousada';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ect-Empresa Brasileira de Correios e Telégrafos', 'ect-empresa-brasileira-de-correios-e-telegrafos', 'Centro', 'Rua Pedro Boufler', '19', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Correios';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671099', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CORREIOS E TELEGRAFOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CORREIOS E TELEGRAFOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Lojas Herval', 'lojas-herval', 'Centro', 'Rua Prof. Laurindo Vier', '40', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Móveis';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671235', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'MOVEIS ESTOFADOS  LOJAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MOVEIS ESTOFADOS  LOJAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Wolf', 'wolf', 'Centro', 'Vrs 833', 'S/N', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Restaurantes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Tintas e Ferragens Nova Era', 'tintas-e-ferragens-nova-era', 'Centro', 'Rua Prof Laurindo Vier', '204', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Ferragens';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135672856', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'FERRAGENS  LOJAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FERRAGENS  LOJAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Delegacia de Polícia Civil', 'delegacia-de-policia-civil', 'Centro', 'Rua Beno Closs', 's/n', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Polícia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671100', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'DELEGACIAS E DISTRITOS POLICIAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'DELEGACIAS E DISTRITOS POLICIAIS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Manga Rosa', 'manga-rosa', 'Centro', 'Est Br', '116', '93990000', -29.5341, -51.08628, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691598', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Adroaldo Diesel', 'adroaldo-diesel', 'Centro', 'Rua Quinze de Novembro', '125', null, -29.5395, -51.08073, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Consultório Médico';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = ' Pediatria, Medicina de Família e Comunidade, Médicos - Pediatria, Medicina de Família e Comunidade HELPSAUDE HELP SAUDE';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, ' Pediatria, Medicina de Família e Comunidade, Médicos - Pediatria, Medicina de Família e Comunidade HELPSAUDE HELP SAUDE', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Beneditto Bistrô', 'beneditto-bistro', 'Centro', 'Rua Anita Garibaldi', '295', null, -29.54073, -51.07966, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Bistrôs';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Fadi - Amizade', 'fadi---amizade', 'Centro', 'Rua Bernardo Schabarum', '50', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Gr Modas', 'gr-modas', 'Centro', 'Rua Anita Garibaldi', '465', '93990000', -29.54111, -51.0813, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Distribuidora de Bebidas Rr', 'distribuidora-de-bebidas-rr', 'Centro', 'Rodovia Br-116', 's/n km 216', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Bebidas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692020', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'BEBIDAS  DEPOSITOS E DISTRIBUIDORES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'BEBIDAS  DEPOSITOS E DISTRIBUIDORES', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Cooperativa Agropecuária Petrópolis', 'cooperativa-agropecuaria-petropolis', 'Centro', 'Rua Pe Willibaldo Scholl', '75', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Cooperativas de Produtores';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671187', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'COOPERATIVAS DE PRODUTORES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'COOPERATIVAS DE PRODUTORES', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Joalheria e Ótica Hahn', 'joalheria-e-otica-hahn', 'Centro', 'Rua Independência', '268', null, -29.54116, -51.08184, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Óticas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692040', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'OTICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'OTICAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Berghahn, Fritsch & Scholles', 'berghahn--fritsch-&-scholles', 'Vale Direito', 'Est Morro Reuter', null, '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Salão de Beleza';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Frigorífico Boa Vista .', 'frigorifico-boa-vista-.', 'Boa Vista', 'Rua Helmuth Schneider', '100', '93995000', -29.4991, -50.9945, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Equipamentos para Indústria Alimentícia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'FRIGORIFICOS CARNE CARNES FRIGORIFICO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FRIGORIFICOS CARNE CARNES FRIGORIFICO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Padaria Schuh', 'padaria-schuh', 'Centro', 'Rua Benno Closs', '4117', null, -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Padarias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135672420', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'Padaria Schuh Santa Maria do Herval';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Padaria Schuh Santa Maria do Herval', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mrc Eletrônica / Mauro Ronei Closs-Me', 'mrc-eletronica--mauro-ronei-closs-me', 'Centro', 'Rua Almiro Closs-27-Centro', '0', null, -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Eletroeletrônicos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671186', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'SKY HDTV É ISSO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SKY HDTV É ISSO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Le Village', 'le-village', 'Rural', 'V Rs 833', '1370', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Artigos e Equipamentos para Festas e Eventos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bar e Restaurante El', 'bar-e-restaurante-el', 'Centro', 'Estr. Vrs', '833', '93990000', -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Comida Variada';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135695021', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Eletrônico Banco Bradesco - Paa', 'caixa-eletronico-banco-bradesco---paa', 'Centro', 'Rua Travessão', '170', '93990000', -29.53417, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Caixas Eletrônicos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Márcia M B Klein', 'marcia-m-b-klein', 'Centro', 'Rua Independência', '306', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Sorveterias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691066', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'SORVETERIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SORVETERIAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Confeitaria Delicia da Serra', 'confeitaria-delicia-da-serra', 'Centro', 'Rodovia Br-116', '1005', '93990000', -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Padarias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692441', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Brilhu\'S Óptica e Joalheria', 'brilhus-optica-e-joalheria', 'Centro', 'Rua Travessão', '170', null, -29.53783, -51.08278, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Jóias e Bjuterias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691222', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'JOIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'JOIAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Matadouro de Aves Avesul  - Picada São Paulo', 'matadouro-de-aves-avesul---picada-sao-paulo', 'Picada São Paulo', 'Rua Alfredo Meurer', 's/n', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Matadouro';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691099', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'MATADOUROS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MATADOUROS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Jaime Eduardo Feiten', 'jaime-eduardo-feiten', 'Centro', 'Rua Prof Laurindo Vier', '122', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Construção Civil';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671070', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'TERRAPLENAGEM';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'TERRAPLENAGEM', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Farmácia Nova', 'farmacia-nova', 'Centro', 'Rua Independência', '306 s 3', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Farmácias e Drogarias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691498', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'FARMACIAS E DROGARIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FARMACIAS E DROGARIAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Backes Esquadrias de Madeira  - São José do Herval', 'backes-esquadrias-de-madeira---sao-jose-do-herval', 'São José do Herval', 'Rua S José Herval', '1700', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Móveis';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135695038', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'MOVEIS  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MOVEIS  ATAC E FAB', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Posto Weber Dppi Estrada Br 116', 'posto-weber-dppi-estrada-br-116', 'Centro', 'Estrada Br 116', '1639', '93990000', -29.53806, -51.08083, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Postos de Combustível';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '5555515691277', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'POSTO DPPI ESTRADA BR 116 ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'POSTO DPPI ESTRADA BR 116 ', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Combustíveis e Auto Peças Weber', 'combustiveis-e-auto-pecas-weber', 'Centro', 'Rodovia Br-116', '1639', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Peças e Acessórios Para Veículos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691277', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'COMBUSTIVEIS  DISTR';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'COMBUSTIVEIS  DISTR', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Associação Riograndense Empre Ass Tec Extensão Rural Emater', 'associacao-riograndense-empre-ass-tec-extensao-rural-emater', 'Centro', 'Rua Prof Laurindo Vier', 's/n', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Pet Shops';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671184', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'AGRICULTURA E PECUARIA  ASSESSORIA E PESQUISA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'AGRICULTURA E PECUARIA  ASSESSORIA E PESQUISA', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Transportes Representações Madilly', 'transportes-representacoes-madilly', 'Centro', 'Rodovia Br-116', 's/n c 16043', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Serviços de Transporte';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692059', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'TRANSPORTE DE PRODUTOS E RESIDUOS QUIMICOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'TRANSPORTE DE PRODUTOS E RESIDUOS QUIMICOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Atelier Solange', 'atelier-solange', 'Centro', 'Rua Bela Vista', '120', null, -29.53699, -51.08601, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Artes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691563', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  ATAC E FAB', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Minimercado Elefante Branco', 'minimercado-elefante-branco', 'Centro', 'Rua Caramuru', '91', null, -29.53853, -51.07962, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Mercearias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692465', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ARMAZENS EMPORIOS E MERCEARIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ARMAZENS EMPORIOS E MERCEARIAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Manga Rosa Malhas', 'manga-rosa-malhas', 'Centro', 'Rodovia Br-116', 's/n', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Materiais para Indústria Têxtil';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691598', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'MALHAS MALHARIAS ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MALHAS MALHARIAS ', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Prefeitura Municipal de Morro Reuter', 'prefeitura-municipal-de-morro-reuter', 'Centro', 'Rodovia Br-116', '1197', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Prédios Públicos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691455', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'PREFEITURAS MUNICIPAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'PREFEITURAS MUNICIPAIS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Produtos Alimentícios Vier  - São José do Herval', 'produtos-alimenticios-vier---sao-jose-do-herval', 'São José do Herval', 'Rua S José Herval', 's/n', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Equipamentos para Indústria Alimentícia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135695080', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ACOUGUES E FRIGORIFICOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ACOUGUES E FRIGORIFICOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Dahchele Indústria Comércio Confecções', 'dahchele-industria-comercio-confeccoes', 'Centro', 'Rodovia Br-116', 's/n km 211', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135697045', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CONFECCOES UNISSEX';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CONFECCOES UNISSEX', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mecânica Kunst', 'mecanica-kunst', 'Centro', 'Rua Walter Fleck', '111', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Mecânicas e Oficinas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671060', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'OFICINAS MECANICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'OFICINAS MECANICAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Fundação Assistencial de Dois Irmãos', 'fundacao-assistencial-de-dois-irmaos', 'Centro', 'Rua Travessão', '153', null, -29.53769, -51.08277, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Escolas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691463', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ESCOLAS DE EDUCACAO INFANTIL';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ESCOLAS DE EDUCACAO INFANTIL', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Indústria de Calçados Wirth', 'industria-de-calcados-wirth', 'Centro', 'Rua Prof. Laurindo Vier', 'S/N', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Vestuário';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135672766', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  ATAC E FAB', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Sindicato dos Trabalhadores Rurais de Dois Irmãos', 'sindicato-dos-trabalhadores-rurais-de-dois-irmaos', 'Centro', 'Rua Anita Garibaldi', '250', null, -29.54047, -51.07927, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Sindicatos e Federações';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691155', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'SINDICATOS E FEDERACOES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SINDICATOS E FEDERACOES', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Nestor A F Souza', 'nestor-a-f-souza', 'Centro', 'Rua João Xxiii', '57', null, -29.53841, -51.08348, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Dentistas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691010', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'DENTISTAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'DENTISTAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bazar Gc', 'bazar-gc', 'Centro', 'Rua Professor Laurindo Vier', null, '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Magazines';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Companhia Estadual de Energia Elétrica-Ceee - Zona Urbana', 'companhia-estadual-de-energia-eletrica-ceee---zona-urbana', 'Zona Urbana', 'Rod Estrada Usina', 's/n', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Empresas de Energia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135672479', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ELETRICIDADE  EMPRESAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ELETRICIDADE  EMPRESAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Floricultura Tropical', 'floricultura-tropical', 'Centro', 'Rua Travessão', '170 s 5', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Flores';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691126', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'FLORICULTURAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FLORICULTURAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Consultório Odontológico Dra Úrsula', 'consultorio-odontologico-dra-ursula', 'Centro', 'Rua Beno Closs', '38 sl 1', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Clínicas Odontológicas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135673000', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'DENTISTAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'DENTISTAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Pró Service Beneficiamento Em Calçados - São Jorge', 'pro-service-beneficiamento-em-calcados---sao-jorge', 'Diehl', 'Rua Guaiba', '1597', null, -29.49693, -51.0801, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135564759', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  LOJAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  LOJAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Centro Integ Em Busca do Tempo de Aprender', 'centro-integ-em-busca-do-tempo-de-aprender', 'Centro', 'Travessa 1Âº De Maio', '46', '93990000', -29.53997, -51.07955, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Escolas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bruno Kunst & Cia', 'bruno-kunst-&-cia', 'Centro', 'Rua Beno Closs', 's/n', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671131', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CEREAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CEREAIS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mini Mercado Amizade', 'mini-mercado-amizade', 'Amizade', 'Rua Beno Closs', '1971', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Supermercados';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ponto Economico', 'ponto-economico', 'Centro', 'Rua Vinte E Um de Abril', null, '93990000', -29.54069, -51.08294, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Atelier de Calcados Vier', 'atelier-de-calcados-vier', 'La Boa V do Herval', 'Est Linha Boa Vista do Herval', null, '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Indústrias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Sandro Calcados', 'sandro-calcados', 'Centro', 'Rua Benno Closs', 'SALA 02', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Supermercado e Agropecuária Piá', 'supermercado-e-agropecuaria-pia', 'Centro', 'Rua Monteiro Lobato', '68', '93990000', -29.54041, -51.08106, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Supermercados';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691188', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = ' ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, ' ', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Moto Pecas e Bazar Raio de Luz', 'moto-pecas-e-bazar-raio-de-luz', 'Centro', 'Rua Dos Imigrantes', '40', '93990000', -29.54386, -51.08724, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Revendedores e Concessionárias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mercado Fleck', 'mercado-fleck', 'Centro', 'Rua Platano', '310', '93990000', -29.54021, -51.08674, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Asmocre', 'asmocre', 'Linha Cristo Rei', 'Est Geral', 'SN', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações e Sindicatos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Fadi - Gente Miuda', 'fadi---gente-miuda', 'Centro', 'Rua TravessÃ£o', '143', '93990000', -29.53755, -51.08275, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Cyberlink Informatica', 'cyberlink-informatica', 'Centro', 'Rua Beno Closs', 'SALA A', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Serviços em Informática';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Transportes Rohr', 'transportes-rohr', 'Rural', 'Est Br 116', null, '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Transporte (Geral)';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Joel Gas', 'joel-gas', 'Centro', 'Rua Pedro Jose Kolling', '1151', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Carmen Beatriz de Souza Torres', 'carmen-beatriz-de-souza-torres', 'Centro', 'Rua do Planalto', '387', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Restaurante Choupannas', 'restaurante-choupannas', 'Centro', 'Rua Quinze de Novembro', '170', '93990000', -29.53929, -51.08038, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Restaurantes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Grade M0veis', 'grade-m0veis', 'B.Vista do Herval', 'Rua Vinte E Cinco de Julho', null, '93995000', -29.54066, -51.07781, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Móveis';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Morro Center Car', 'morro-center-car', 'Centro', 'Rodovia Br-116', '2600', '93990000', -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Locadoras de Veículos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Agua Na Boca', 'agua-na-boca', 'Centro', 'Rua Beno Closs', 'SALA 04', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Padarias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Nene Lanches', 'nene-lanches', 'Centro', 'Rua Vinte E Um de Abril', null, '93990000', -29.54069, -51.08294, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Lanchonetes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Loja Fuhr', 'loja-fuhr', 'Centro', 'Rua Anita Garibaldi', '205', '93990000', -29.54024, -51.07891, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Partido Trabalhista Brasileiro - Ptb', 'partido-trabalhista-brasileiro---ptb', 'Centro', 'Rua Professor Laurindo Vier', '1005', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Prédios Públicos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Unidade Municipal de Saude M Reuter', 'unidade-municipal-de-saude-m-reuter', 'Centro', 'Rua Anita Garibaldi', '274', null, -29.54061, -51.07947, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Centros e Postos de Saúde';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = ' HELPSAUDE HELP SAUDE';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, ' HELPSAUDE HELP SAUDE', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mallmann Representaoes', 'mallmann-representaoes', 'Centro', 'Rua do Planalto', '341', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Terraplanagem Lehnen', 'terraplanagem-lehnen', 'Centro', 'Rua Piratini', '121', '93990000', -29.53675, -51.08138, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Construção Civil';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691369', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  ART PARA FABRICAR';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  ART PARA FABRICAR', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Kmb Supermercados', 'kmb-supermercados', 'Centro', 'Rua Travessão', null, '93990000', -29.53888, -51.0829, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Supermercados';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bruna Calcados Mundi', 'bruna-calcados-mundi', 'Centro', 'Rua Professor Laurindo Vier', 'SALA 02', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Escolar da E. E. E. M. Joao Wagner', 'caixa-escolar-da-e.-e.-e.-m.-joao-wagner', 'Centro', 'Rua Anita Garibaldi', '275', '93990000', -29.54062, -51.07949, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Caixas Eletrônicos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bar e Armazem do Gomes', 'bar-e-armazem-do-gomes', 'Rural', 'Est Nova Renania', '108', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Balada';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Companhia Riograndense de Saneamento-Corsan', 'companhia-riograndense-de-saneamento-corsan', 'Centro', 'Rua Beno Closs', 'S/N', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Água e Esgoto';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671030', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'SANEAMENTO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SANEAMENTO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Germânia Calçados', 'germania-calcados', 'Centro', 'Rua João Xxiii', '100', null, -29.53848, -51.08308, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Vestuário';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692345', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  LOJAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  LOJAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Posto de Combustiveis Morro Reuter  Charrua R Joao Linck Filho', 'posto-de-combustiveis-morro-reuter-charrua-r-joao-linck-filho', 'Centro', 'Rua Joao Linck Filho', null, '93900000', -29.53806, -51.08083, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Postos de Combustível';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692453', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'POSTO CHARRUA R JOAO LINCK FILHO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'POSTO CHARRUA R JOAO LINCK FILHO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Dy\'Modas', 'dymodas', 'Centro', 'Rua Independencia', '306', '93990000', -29.54154, -51.08181, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Pmdb', 'pmdb', 'Centro', 'Rua Anita Garibaldi', null, '93990000', -29.54015, -51.07877, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações e Sindicatos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Nova Era Tintas e Ferragens', 'nova-era-tintas-e-ferragens', 'Centro', 'Rua Professor Laurindo Vier', '201', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Ferragens';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Action Lan House', 'action-lan-house', 'Centro', 'Rua João Xxiii', '100', '93990000', -29.53848, -51.08308, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Lan Houses';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Blush Modas', 'blush-modas', 'Centro', 'Rua Platano', '302', '93990000', -29.54021, -51.08674, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Rsb Confeccoes', 'rsb-confeccoes', 'Centro', 'Rua Arthur Zimmer', null, '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Vidracaria Farias', 'vidracaria-farias', 'Centro', 'Rua Bento Gonçalves', '93', '93990000', -29.54001, -51.08022, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Vidraçarias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Armazem Cavallin', 'armazem-cavallin', 'Nova Renania', 'Rua Vinte E Cinco de Julho', null, '93995000', -29.54066, -51.07781, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Mercearias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Partido Trabalhista Brasileiro - Ptb', 'partido-trabalhista-brasileiro---ptb', 'Centro', 'Rua Quinze de Novembro', null, '93990000', -29.54054, -51.0698, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Prédios Públicos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Afmmr', 'afmmr', 'Centro', 'Rua Alberto Schuk', null, '93990000', -29.5388, -51.08561, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações e Sindicatos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bar Mai', 'bar-mai', 'Picada Sao Paulo', 'Rua 13 de Janeiro', null, '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Rio Grande Turismo', 'rio-grande-turismo', 'Amizade', 'Rua Treze de Outubro', '105', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Viagem e Turismo';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Apm - Gente Miuda', 'apm---gente-miuda', 'Centro', 'Rua Travessão', null, '93990000', -29.53888, -51.0829, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações e Sindicatos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'J. A. Esquadrias Metalicas', 'j.-a.-esquadrias-metalicas', 'Sem Denominacao', 'Rua Pedro Jose Kolling', null, '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Materiais de Construção';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Commander Artigos Funerarios', 'commander-artigos-funerarios', 'Birckenthal', 'Rua Duque de Caxias', 'FUNDOS', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Indústrias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Lszk', 'lszk', 'Centro', 'Rua Rua Benno Closs,', '38', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Fundo de Previdencia Social do Municipio', 'fundo-de-previdencia-social-do-municipio', 'Centro', 'Rodovia Br-116', '7837', '93990000', -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Bancos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ponto Economico', 'ponto-economico', 'Centro', 'Rua Jaco Erico Schmitz', '25', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Eis Berg', 'eis-berg', 'Centro', 'Est Rodovia Br 116', '6000', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Apm - Amizade', 'apm---amizade', 'Vila Amizade', 'Rua Bernardo Schabarum', null, '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações e Sindicatos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Chica Maria Congelados', 'chica-maria-congelados', 'Centro', 'Rua Independência', '256', '93990000', -29.54106, -51.08184, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Minimercado e Acougue Jf', 'minimercado-e-acougue-jf', 'Centro', 'Rua Vinte E Cinco de Julho', null, '93995000', -29.54066, -51.07781, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mercado Walachai', 'mercado-walachai', 'Walachai', 'Est Walachai', null, '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Armazem Klauck', 'armazem-klauck', 'Picada Sao Paulo', 'EST ROD BR 116', '23516', '93990000', -29.54234, -51.08216, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Armazéns Gerais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ls Bolsas', 'ls-bolsas', 'Planalto', 'Rua Cristiano Fuhr', '1055', '93990000', -29.54429, -51.08916, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Acessórios de Moda';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Construtora Haubert', 'construtora-haubert', 'Amizade', 'Rua Beno Closs', '1900', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Construção Civil';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ipiranga', 'ipiranga', 'Centro', 'Rodovia Br-116', 'km 216', '93990000', -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Postos de Combustível';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135912500', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Padaria e Confeitaria Reuter', 'padaria-e-confeitaria-reuter', 'Centro', 'Rua Anita Garibaldi', null, '93990000', -29.54015, -51.07877, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Padarias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Loja da Leti', 'loja-da-leti', 'Walachai', 'Rua Nacoes Unidas', 'VL DIETER', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ctg Amigos da Tradicao', 'ctg-amigos-da-tradicao', 'Vila Kuntz', 'Rua Wilibaldo Schneck', 'SN', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Centros Culturais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Fb Digital Fotografia', 'fb-digital-fotografia', 'Centro', 'Rua Joao Xiii', '55', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Fotografia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'D Sonhos Colchoes', 'd-sonhos-colchoes', 'Centro', 'Rua Monteiro Lobato', '244', '93990000', -29.54181, -51.08033, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Cama, Mesa e Banho';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ambulatorio H Doze de Maio Sm do Herval', 'ambulatorio-h-doze-de-maio-sm-do-herval', 'Centro', 'Rua Albano Shneider', '23', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Hospitais Públicos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = ' HELPSAUDE HELP SAUDE';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, ' HELPSAUDE HELP SAUDE', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Vitor Alberto Griesbach & Cia', 'vitor-alberto-griesbach-&-cia', 'Centro', 'Rua Arthur Alfredo Hoffmeister', '109', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Floricultura da Serra', 'floricultura-da-serra', 'Sao Jose do Herval', 'Est Vrs 873', null, '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Flores';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Coopermore', 'coopermore', 'Centro', 'Rua Anita Garibaldi', 'segundo andar', '93990000', -29.54015, -51.07877, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações e Sindicatos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Megaton Moda Jovem', 'megaton-moda-jovem', 'Walachai', 'Rua Geral Santa M do Herval', 'S/N', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Kimisul Tintas', 'kimisul-tintas', 'Vila Nova', 'Rua Professor Laurindo Vier', '638', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Indústrias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Deutsche Schlachterei', 'deutsche-schlachterei', 'Sao Jose do Herval', 'Rua Sao Jose do Herval', null, '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Heimat Pousada Colonial', 'heimat-pousada-colonial', 'Padre Eterno Ilges', 'Est Padre Eterno', '381', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Pousada';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ovos Filippsen', 'ovos-filippsen', 'Picada Sao Paulo', 'Rua Duque de Caxias', null, '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Agricultura e Pecuária';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Anelise Bredow Atelie de Arte Ceramica e Design', 'anelise-bredow-atelie-de-arte-ceramica-e-design', 'Centro', 'Est Br 116', '851', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Artes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Restaurante Alles', 'restaurante-alles', 'Centro', 'Rua 25 de Julho', '2809', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Restaurantes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Barbi Calcados e Confeccoes', 'barbi-calcados-e-confeccoes', 'Nova Renania', 'Est Nova Renania', null, '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Eletro Eletronica Fases', 'eletro-eletronica-fases', 'Centro', 'Rua Benno Closs', '38', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Eletroeletrônicos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Lavacar Stani', 'lavacar-stani', 'Centro', 'Rua João Xxiii', '330', '93990000', -29.53905, -51.08092, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Farmacia Nova', 'farmacia-nova', 'Centro', 'Rua Anita Garibaldi', '286', '93990000', -29.54068, -51.07957, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Farmácias de Manipulação';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Elcio Starck Machado', 'elcio-starck-machado', 'Centro', 'Rua Laurindo Vier', '306', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Consultório Médico';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = ' Ginecologia e Obstetrícia, Clínica Médica, Ipe Saúde, Obstetrícia, Obstetricia, Médicos - Clínica Geral, Ginecologia e Obstetrícia, Ginecologia, Colposcopia, Clínica Médica HELPSAUDE HELP SAUDE';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, ' Ginecologia e Obstetrícia, Clínica Médica, Ipe Saúde, Obstetrícia, Obstetricia, Médicos - Clínica Geral, Ginecologia e Obstetrícia, Ginecologia, Colposcopia, Clínica Médica HELPSAUDE HELP SAUDE', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Radio Legal', 'radio-legal', 'Centro', 'Rua Quinze de Novembro', '190', '93990000', -29.53919, -51.08021, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações e Sindicatos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ecolimpe', 'ecolimpe', 'Centro', 'Rua Bela Vista', '76', '93990000', -29.5366, -51.08595, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Indústrias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Km Malhas e Confeccoes', 'km-malhas-e-confeccoes', 'Vila Ferraria', 'Rua Vinte E Cinco de Julho', '11', '93995000', -29.5402, -51.07868, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Floricultura da Serra', 'floricultura-da-serra', 'Centro', 'Rua Benno Closs', 'SALA 04', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Flores';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Asmowa', 'asmowa', 'Walachai', 'EST WALACHAI', '750', '93990000', -29.54234, -51.08216, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Cooherval', 'cooherval', 'Boa Vista do Herval', 'Rua Vinte E Cinco de Julho', '565', '93995000', -29.54066, -51.07781, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Indústrias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Asmok', 'asmok', 'Loteamento Knorst', 'Rua A', 'S/NR.', '93990000', -29.53924, -51.08294, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações e Sindicatos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Supermercado e Agropecuária Piá', 'supermercado-e-agropecuaria-pia', 'Centro', 'Rua Willibaldo Schell,Pe', '75', '93995000', -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Supermercados';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671166', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = ' ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, ' ', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Esquadrias Alseno', 'esquadrias-alseno', 'Padre Eterno Baixo', 'Est Pe. Eterno Baixo', 'S/N', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Móveis';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Cristal Optica e Relojoaria', 'cristal-optica-e-relojoaria', 'Centro', 'Rua Conigo Afonso Wiest', '140', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Relógios';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Calcadao Comercio e Transportes', 'calcadao-comercio-e-transportes', 'Centro', 'Rua Vinte E Cinco de Julho', '2885', '93995000', -29.54066, -51.07781, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Transporte (Geral)';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Neka Modas', 'neka-modas', 'Centro', 'Rua Beno Closs', 'LOJA 03', '93995000', -29.499, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Transcas', 'transcas', 'Rural', 'Rodovia Br-116', 's/n', '93990000', -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Endereços Empresariais';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Recanto da Moda', 'recanto-da-moda', 'Rural', 'Rua Vinte E Cinco de Julho', 'frente', '93995000', -29.54066, -51.07781, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Vestuário';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Consultorio Odonto Smdo Herval', 'consultorio-odonto-smdo-herval', 'Centro', 'Rua Albano Schneider', '23', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Clínicas Médicas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = ' HELPSAUDE HELP SAUDE';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, ' HELPSAUDE HELP SAUDE', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Astro Vivo', 'astro-vivo', 'Sao Jose', 'Est do Mato Cumprido', '3030', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Telefonia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Unidade Movel S Maria do Herval', 'unidade-movel-s-maria-do-herval', 'Centro', 'Rua Beno Clos', '88', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Medicina e Saúde (Geral)';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = ' HELPSAUDE HELP SAUDE';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, ' HELPSAUDE HELP SAUDE', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'H. S. Projetos', 'h.-s.-projetos', 'Sao Jose do Herval', 'Rua Floresta', '35', '93990000', -29.534, -51.08652, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Escritório de Engenharia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bier Comunicacoes', 'bier-comunicacoes', 'Centro', 'Rua Bela Vista', '270', '93990000', -29.53817, -51.08657, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Comunicação Visual';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ls Beneficiamento de Calçados', 'ls-beneficiamento-de-calcados', 'Centro', 'Rua Arthur Alfredo Hoffmeister', '880', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Vestuário';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691011', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  LOJAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  LOJAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Filippsen-Componentes Em Eva - Zona Rural', 'filippsen-componentes-em-eva---zona-rural', 'Zona Rural', 'Rua Dq. de Caxias', '1110', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Agricultura e Pecuária';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691174', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  ART PARA FABRICAR';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  ART PARA FABRICAR', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Um Toque A Mais', 'um-toque-a-mais', 'Centro', 'Rua Independência', '268', null, -29.54116, -51.08184, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Salão de Beleza';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692289', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CABELEIREIROS E INSTITUTOS DE BELEZA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CABELEIREIROS E INSTITUTOS DE BELEZA', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Drogaria Daniel', 'drogaria-daniel', 'Centro', 'Rua Travessão', 's/n', null, -29.53888, -51.0829, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Farmácias e Drogarias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691022', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'FARMACIAS E DROGARIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FARMACIAS E DROGARIAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Hc Couros e Representações', 'hc-couros-e-representacoes', 'Centro', 'Rua Travessão', '170', null, -29.53783, -51.08278, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Materiais para Indústria Têxtil';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691212', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'COURO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'COURO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Madeireira Herval', 'madeireira-herval', 'Centro', 'Rua Bento Gonçalves', '49', null, -29.54024, -51.08059, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Móveis';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691522', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'MOVEIS  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MOVEIS  ATAC E FAB', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, '24 Bpm Bm', '24-bpm-bm', 'Centro', 'Rua Anita Garibaldi', '299', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações de Classe';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691111', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ASSOCIACOES DE CLASSE';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ASSOCIACOES DE CLASSE', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Posto de Combustíveis Morro Reuter', 'posto-de-combustiveis-morro-reuter', 'Centro', 'Rodovia Br-116', 's/n km 216', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Postos de Combustível';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691036', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'POSTOS DE COMBUSTIVEIS E SERVICOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'POSTOS DE COMBUSTIVEIS E SERVICOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Calçados Sophia', 'calcados-sophia', 'Centro', 'Rua Almiro Clous', '11', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Vestuário';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135672863', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  ART PARA FABRICAR';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  ART PARA FABRICAR', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Piratini Logística Transportes', 'piratini-logistica-transportes', 'Centro', 'Rua Beno Closs', '38 s 3', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Serviços de Transporte';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135672136', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'LOGISTICA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LOGISTICA', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Guido Wiest', 'guido-wiest', 'Centro', 'Rua Monteiro Lobato', '138', null, -29.54093, -51.08068, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Contabilidade';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691551', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CONTABILIDADE  ESCRITORIOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CONTABILIDADE  ESCRITORIOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Malhas Werle  - Picada São Paulo', 'malhas-werle---picada-sao-paulo', 'Picada São Paulo', 'Rua Alfredo Meurer', 'S/N', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Materiais para Indústria Têxtil';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691377', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'MALHAS MALHARIAS ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MALHAS MALHARIAS ', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Aes Sul Distribuidora Gaúcha de Energia S/A', 'aes-sul-distribuidora-gaucha-de-energia-sa', 'Centro', 'Rua Alberto Schuk', '90', null, -29.53909, -51.08384, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Empresas de Energia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692999', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ELETRICIDADE  EMPRESAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ELETRICIDADE  EMPRESAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Posto Herval Charrua R 25 de Julho', 'posto-herval-charrua-r-25-de-julho', 'Boa Vista do Herval', 'Rua Vinte E Cinco de Julho', '2901', '93995000', -29.54066, -51.07781, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Postos de Combustível';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '5555515672531', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'POSTO CHARRUA R 25 DE JULHO ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'POSTO CHARRUA R 25 DE JULHO ', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Reinheimer e Weber L', 'reinheimer-e-weber-l', 'Centro', 'Br', 's/n', '93990000', -29.55163, -51.09067, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Restaurantes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691074', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Malhas Werle Limitada', 'malhas-werle-limitada', 'Centro', 'Tv Br', '80', '93990000', -29.5341, -51.08628, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691366', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Wiest & Felice', 'wiest-&-felice', 'Centro', 'Rod Br 116', 's/n km 213', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Materiais para Indústria Têxtil';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691125', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'COURO  ARTEF  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'COURO  ARTEF  ATAC E FAB', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Laboratório Alfa', 'laboratorio-alfa', 'Centro', 'Rua Independência', '236 7', null, -29.54088, -51.08185, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Laboratórios';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691488', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'LABORATORIOS DE ANALISE DE DNA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LABORATORIOS DE ANALISE DE DNA', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Irmãos Hoffmeister', 'irmaos-hoffmeister', 'Centro', 'Rua Arthur Alfredo Hoffmeister', '360', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Equipamentos para Indústria Alimentícia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691122', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ACOUGUES E FRIGORIFICOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ACOUGUES E FRIGORIFICOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Agrilar Produtos Agrícolas', 'agrilar-produtos-agricolas', 'Centro', 'Rua Beno Closs', '150', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Equipamentos e Máquinas Agrícolas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671171', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'AGRICULTURA E PECUARIA  ESTABELECIMENTOS E PRODUTOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'AGRICULTURA E PECUARIA  ESTABELECIMENTOS E PRODUTOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Celestino Graeff Cia', 'celestino-graeff-cia', 'Centro', 'Rua 21 de Abril', '3', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Confeccões';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691255', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CONFECCOES UNISSEX';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CONFECCOES UNISSEX', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Paróquia Imaculada Conceição do Morro Reuter', 'paroquia-imaculada-conceicao-do-morro-reuter', 'Centro', 'Rua João Xxiii', 's/n', null, -29.53893, -51.08132, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Igrejas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691423', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'IGREJAS TEMPLOS E INSTITUICOES RELIGIOSAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'IGREJAS TEMPLOS E INSTITUICOES RELIGIOSAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Rede Energia', 'rede-energia', 'Centro', 'Rodovia Br-116', '1639', '93990000', -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Postos de Combustível';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135912500', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'POSTO DPPI RODOVIA BR 116 ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'POSTO DPPI RODOVIA BR 116 ', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Sociedade Caritativa e Literária São Francisco de Assis - Zona Rural', 'sociedade-caritativa-e-literaria-sao-francisco-de-assis---zona-rural', 'Zona Rural', 'Est S José Herval', 's/n', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Associações Beneficentes';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135014303', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ASSOCIACOES BENEFICENTES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ASSOCIACOES BENEFICENTES', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'H Kuntzler & Cia - Padre Eterno', 'h-kuntzler-&-cia---padre-eterno', 'Padre Eterno', 'Rua Pe. Eterno Ilges', 'S/N', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Postos de Combustível';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671178', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  ATAC E FAB', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mogiana Indústria de Produtos Químicos - Zona Rural', 'mogiana-industria-de-produtos-quimicos---zona-rural', 'Zona Rural', 'Tv Picada Verão', '410', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Produtos Químicos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135695062', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'PRODUTOS QUIMICOS  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'PRODUTOS QUIMICOS  ATAC E FAB', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Banrisul - Banco do Estado do Rio Grande do Sul - Agência Santa Maria', 'banrisul---banco-do-estado-do-rio-grande-do-sul---agencia-santa-maria', 'Centro', 'Rua 12 de Maio', '129 sl 1', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Bancos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671177', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'BANCOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'BANCOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Eletrofinos Conserto Eletrodomésticos Em Geral', 'eletrofinos-conserto-eletrodomesticos-em-geral', 'Centro', 'Rua Independência', '236 2', null, -29.54088, -51.08185, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Geladeiras e Freezers';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692067', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ELETRODOMESTICOS  CONSERTO E PECAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ELETRODOMESTICOS  CONSERTO E PECAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Jp Deimling e Cia', 'jp-deimling-e-cia', 'Centro', 'Rod Br 116', 's/n km 216', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Materiais de Construção';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691233', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ESQUADRIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ESQUADRIAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Lauri Fuhr', 'lauri-fuhr', 'Centro', 'Rua Alcindo Oscar Hoffmeister', '14', null, -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Materiais de Construção';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691020', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ESQUADRIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ESQUADRIAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mecanica Rpm', 'mecanica-rpm', 'Centro', 'Tv. Br.', '152', '93990000', -29.53404, -51.08649, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Revendedores e Concessionárias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691427', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Alexandre Backes Backes & Cia', 'alexandre-backes-backes-&-cia', 'Centro', 'Rua Vinte e Um de Abril', '82', null, -29.54061, -51.08267, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Vestuário';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691612', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'ROUPAS INFANTIS  LOJAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ROUPAS INFANTIS  LOJAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Corsan-Companhia Riograndense de Saneamento', 'corsan-companhia-riograndense-de-saneamento', 'Centro', 'Rua Beno Closs', 'S/N', null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Água e Esgoto';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671030', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'SANEAMENTO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SANEAMENTO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Marino Scholles e Cia', 'marino-scholles-e-cia', 'Centro', 'Rua Castro Alves', '36', null, -29.53945, -51.08003, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Supermercados';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691177', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'SUPERMERCADOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SUPERMERCADOS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Serralheria Scholl', 'serralheria-scholl', 'Centro', 'Rodovia Br-116', 's/n km 216', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Serviços em Construção';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691100', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'SERRALHEIROS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SERRALHEIROS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mitra da Diocese de Novo Hamburgo', 'mitra-da-diocese-de-novo-hamburgo', 'Centro', 'Rua João Xxiii', 's/n', null, -29.53893, -51.08132, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Igrejas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691266', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'IGREJAS TEMPLOS E INSTITUICOES RELIGIOSAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'IGREJAS TEMPLOS E INSTITUICOES RELIGIOSAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Airton José Krewer', 'airton-jose-krewer', 'Centro', 'Rua João Xxiii', '330', null, -29.53905, -51.08092, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Lava-Rápido';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691370', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'LAVA RAPIDO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LAVA RAPIDO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Farmácia Herval', 'farmacia-herval', 'Centro', 'Rua Prof Laurindo Vier', '208 sl 1', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Farmácias e Drogarias';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671004', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'FARMACIAS E DROGARIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FARMACIAS E DROGARIAS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Casa Lotérica Bazar Gc', 'casa-loterica-bazar-gc', 'Centro', 'Rua Professor Laurindo Vier 000', null, null, -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Casas Lotéricas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '558007260101', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Hc Calcados', 'hc-calcados', 'Centro', 'Rua Travessão', '170 1', '93990000', -29.53783, -51.08278, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Vestuário';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691212', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'CALCADOS  LOJAS SAPATO SANDALIA TENIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  LOJAS SAPATO SANDALIA TENIS', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Produtos Coloniais Broilo', 'produtos-coloniais-broilo', 'Centro', 'Rodovia Br-116', null, '93990000', -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135691044', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'PRODUTOS ALIMENTICIOS ALIMENTOS ALIMENTICIO ALIMENTO ALIMENTACAO COMIDA COMESTIVEL';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'PRODUTOS ALIMENTICIOS ALIMENTOS ALIMENTICIO ALIMENTO ALIMENTACAO COMIDA COMESTIVEL', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Roberto Acker', 'roberto-acker', 'Centro', 'Rua Platano', '558', '93990000', -29.54021, -51.08674, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Telemensagens';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135692341', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'TELEMENSAGENS TELEMENSAGEM';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'TELEMENSAGENS TELEMENSAGEM', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'S T I Calcados', 's-t-i-calcados', 'Centro', 'Rua Beno Closs 355', null, '93995000', -29.49912, -50.99448, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Vestuário';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135671095', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'SINDICATOS E FEDERACOES FEDERACAO TRABALHADOR TRABALHADORES SINDICAIS SINDICATO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SINDICATOS E FEDERACOES FEDERACAO TRABALHADOR TRABALHADORES SINDICAIS SINDICATO', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Pousada Natureza Sanadora', 'pousada-natureza-sanadora', 'Sem Informacao', 'Rodovia Br-116', '0', null, -29.5496, -51.08624, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Pousada';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555192681990', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'SANADORA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SANADORA', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Metalúrgica Herval', 'metalurgica-herval', 'Centro', 'Rua Willibaldo Clement', 'S/N', null, -29.48066, -51.04742, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Materiais de Construção';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135672419', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorTagMax;
        FETCH cursorTagMax INTO v_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_tag_id_max = null;
        END IF;
        CLOSE cursorTagMax;
        SET v_tag_id_max = v_tag_id_max + 1;
        SET v_tag_name = 'Metalúrgica Herval';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Metalúrgica Herval', now(), now());
        ELSE
            SET v_tag_id_max = v_tag_id_exists;
        END IF;
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdTagMax;
        FETCH cursorAdTagMax INTO v_ad_tag_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_tag_id_max = null;
        END IF;
        CLOSE cursorAdTagMax;
        SET v_ad_tag_id_max = v_ad_tag_id_max + 1;
        INSERT INTO AD_TAG_TBL(id, ad_id, tag_id, created_at, updated_at) VALUES(v_ad_tag_id_max, v_ad_id_max, v_tag_id_max, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'morro-reuter';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Casa Lotérica Loterica Parada da Sorte', 'casa-loterica-loterica-parada-da-sorte', 'Centro', 'Rua Travessão', '170', null, -29.53783, -51.08278, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Casas Lotéricas';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
    SET v_record_counter = COALESCE(v_record_counter, 0) + 1;
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
    CLOSE cursorCountry;
    SET v_state_acronym = 'RS';
    SET v_cursor_not_found = FALSE;
    OPEN cursorState;
    FETCH cursorState INTO v_state_id;
    IF v_cursor_not_found THEN
        SET v_state_id = null;
    END IF;
    CLOSE cursorState;
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        SET v_record_added_counter = COALESCE(v_record_added_counter, 0) + 1;
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Comercial Staudt', 'comercial-staudt', 'Uniao', 'Est Para Morro Reuter', '65', '93950000', -29.589, -51.09103, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Alimentos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorCategory;
        FETCH cursorCategory INTO v_category_id;
        IF v_cursor_not_found THEN
            SET v_category_id = null;
        END IF;
        CLOSE cursorCategory;
        INSERT INTO AD_CATEGORY_TBL(id, ad_id, category_id, created_at, updated_at) VALUES(v_ad_category_id_max, v_ad_id_max, v_category_id, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641778', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 1, now(), now());
    END IF;
    -- end ad record
    INSERT INTO LOG_TBL(records, records_added) VALUES(v_record_counter, v_record_added_counter);
END;
//
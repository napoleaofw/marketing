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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Arte Mania Comunicação Gráfica', 'arte-mania-comunicacao-grafica', 'Canudos', 'Rua Bartolomeu de Gusmão', '1068', '93542000', -29.68449, -51.09856, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Papelarias';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555199209559', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Farmácia Pague Menos', 'farmacia-pague-menos', 'Centro', 'Rua Joaquim Nabuco', '714', '93310002', -29.68367, -51.13046, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135931784', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Setjulio Letreiros', 'setjulio-letreiros', 'Industrial', 'Rua Sete de Setembro', '777', '93332470', -29.71249, -51.13895, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Mídia Exterior';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130355567', now(), now());
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
        SET v_tag_name = 'Letreiros, Luminosos, ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Letreiros, Luminosos, ', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Localiza Rent A Car -  Novo Hamburgo', 'localiza-rent-a-car---novo-hamburgo', 'Rio Branco', 'Avenida Coronel Frederico Linck', '345', '93336001', -29.69145, -51.13995, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135821331', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Cepos Ideal', 'cepos-ideal', 'Canudos', 'Rua Bartolomeu de Gusmão', '1805', '93546000', -29.69177, -51.09931, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135250706', now(), now());
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
        SET v_tag_name = 'CALCADOS  ATACADO E FABRICACAO SAPATO SANDALIA TENIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CALCADOS  ATACADO E FABRICACAO SAPATO SANDALIA TENIS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Studio de Beleza Blonde Hair', 'studio-de-beleza-blonde-hair', 'Primavera', 'Rua Oswaldo Cruz', '157', '93340000', -29.68732, -51.14454, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555134341659', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ra Cabeleireiros', 'ra-cabeleireiros', 'Ouro Branco', 'Rua Bento Gonçalves', '1439', '93410002', -29.69378, -51.12679, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135824885', now(), now());
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
        SET v_tag_name = 'CABELEIREIROS E INSTITUTOS DE BELEZA MANICURE PEDICURE CORTE ESCOVA HIDRATACAO CABELEIREIRO SALAO DE BELEZA MAQUIAGEM MAQUIADOR PENTEADO DEPILACAO CABELO DIA DA NOIVA CABELOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CABELEIREIROS E INSTITUTOS DE BELEZA MANICURE PEDICURE CORTE ESCOVA HIDRATACAO CABELEIREIRO SALAO DE BELEZA MAQUIAGEM MAQUIADOR PENTEADO DEPILACAO CABELO DIA DA NOIVA CABELOS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Estrela Embalagens', 'estrela-embalagens', 'Lomba Grande', 'Rua Carlos André Beck', '135', null, -29.6846, -51.14186, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Embalagens';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135962205', now(), now());
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
        SET v_tag_name = 'Sacolas, Sacos plásticos, Produtos de Limpeza, Linha de festa';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Sacolas, Sacos plásticos, Produtos de Limpeza, Linha de festa', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Office Shop', 'office-shop', 'Ouro Branco', 'Avenida Pedro Adams Fo.', '4187', '93320005', -29.69529, -51.12914, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130656565', now(), now());
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
        SET v_tag_name = 'móveis, escritório, cadeiras, mesas, poltronas, estações, novo hamburgo';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'móveis, escritório, cadeiras, mesas, poltronas, estações, novo hamburgo', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Divina Flor', 'divina-flor', 'Rio Branco', 'Rua Vinte E Cinco de Julho', '712', '93310251', -29.68436, -51.13791, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130663843', now(), now());
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
        SET v_tag_name = 'FLORICULTURAS CESTA CESTA DE CAFE DA MANHA CESTAS FINAS CESTAS ESPECIAIS ARRANJO CESTAS PRESENTE ARRANJOS FLORAIS CESTA DE FLORES CESTAS VINHO ARRANJO FLORAL FLORICULTURA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FLORICULTURAS CESTA CESTA DE CAFE DA MANHA CESTAS FINAS CESTAS ESPECIAIS ARRANJO CESTAS PRESENTE ARRANJOS FLORAIS CESTA DE FLORES CESTAS VINHO ARRANJO FLORAL FLORICULTURA', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Kunst,Janequeite Lopes', 'kunst-janequeite-lopes', 'Mauá', 'Rua Sapiranga', null, '93548050', -29.69026, -51.10954, now(), now());
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
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135934421', now(), now());
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
        SET v_tag_name = 'ADVOGADOS ASSESSORIA JURIDICA CONSULTORIA JURIDICA DIREITO ADVOCACIA ADVOGADO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ADVOGADOS ASSESSORIA JURIDICA CONSULTORIA JURIDICA DIREITO ADVOCACIA ADVOGADO', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Tatiana Barcelos', 'tatiana-barcelos', 'São Jorge', 'Rua Gen. Vargas', '344 01', '93534530', -29.67112, -51.10105, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135879248', now(), now());
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
        SET v_tag_name = 'ROUPAS FEMININAS  LOJAS VESTUARIO ROUPA FEMININA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ROUPAS FEMININAS  LOJAS VESTUARIO ROUPA FEMININA', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Projeto Frutificar', 'projeto-frutificar', 'Ouro Branco', 'Avenida Pedro Adams Fo.', '3727', '93320004', -29.69948, -51.13156, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135949027', now(), now());
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
        SET v_tag_name = 'OBRA SOCIAL';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'OBRA SOCIAL', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Livrosul Encadernacoes', 'livrosul-encadernacoes', 'Canudos', 'Rua Adolfo Lutz', '1125', '93540190', -29.68619, -51.1018, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Gráficas e Cópias';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135832204', now(), now());
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
        SET v_tag_name = 'ENCADERNADORES ENCADERNACOES ENCADERNADORA COPIADORA PAPELARIA ENCARDENACAO PERFURADORAS GRAFICA ENCADERNADOR';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ENCADERNADORES ENCADERNACOES ENCADERNADORA COPIADORA PAPELARIA ENCARDENACAO PERFURADORAS GRAFICA ENCADERNADOR', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'D Y C Daniel', 'd-y-c-daniel', 'Ouro Branco', 'Avenida Pedro Adams Fo.', '5013', '93320006', -29.68836, -51.12922, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135932025', now(), now());
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
        SET v_tag_name = 'BEBIDAS  REPRESENTANTES BEBIDA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'BEBIDAS  REPRESENTANTES BEBIDA', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Projety Decorações', 'projety-decoracoes', 'Centro', 'rua visconde de taunay 550', '0', null, -29.685, -51.14186, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Decoração';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130665534', now(), now());
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
        SET v_tag_name = 'cortinas/persianas/papel pared';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'cortinas/persianas/papel pared', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Origy Networks - Desenvolvimento de Sites, Hospedagem de Sites', 'origy-networks---desenvolvimento-de-sites--hospedagem-de-sites', 'Primavera', 'Rua Oswaldo Cruz', '516', '93340000', -29.68773, -51.14842, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Serviços de Internet';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130357272', now(), now());
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
        SET v_tag_name = 'sites, domínios, hospedagem de sites, desenvolvimento de sites, criação de sites';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'sites, domínios, hospedagem de sites, desenvolvimento de sites, criação de sites', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Master Frezeer', 'master-frezeer', 'Boa Vista', 'Rua Alegrete', null, '93410560', -29.69815, -51.12381, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Ar-Condicionado';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135942413', now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555184994017', now(), now());
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
        SET v_tag_name = 'AR CONDICIONADO REFRIGERACAO CONDICIONADOR CLIMATIZACAO COMPRESSORES CLIMATIZADORES REFRIGERADOR';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'AR CONDICIONADO REFRIGERACAO CONDICIONADOR CLIMATIZACAO COMPRESSORES CLIMATIZADORES REFRIGERADOR', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Aicsul', 'aicsul', 'Centro', 'Rua Lucas de Oliveira', '49 801', '93510110', -29.68237, -51.12736, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135933645', now(), now());
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
        SET v_tag_name = 'ASSOCIACOES DE CLASSES ASSOCIACAO DE CLASSE';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ASSOCIACOES DE CLASSES ASSOCIACAO DE CLASSE', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Cantina D\'Irene', 'cantina-direne', 'Centro', 'R Marcilio Dias', '1091-Rio Branco', null, -29.685, -51.14186, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Cantinas';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135941191', now(), now());
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
        SET v_tag_name = 'cantina, restaurante, italiana';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'cantina, restaurante, italiana', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Automatec Equipamentos Para Automação Industrial - Rincão', 'automatec-equipamentos-para-automacao-industrial---rincao', 'Ideal', 'Rua Da Seringueira', '65', '93334500', -29.71134, -51.14093, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Automação Industrial';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130355551', now(), now());
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
        SET v_tag_name = 'AUTOMACAO INDUSTRIAL';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'AUTOMACAO INDUSTRIAL', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Imóveis Rossi - Apartamento Mauá - Novo Hamburgo', 'imoveis-rossi---apartamento-maua---novo-hamburgo', 'Mauá', 'Rua Encruzilhada do Sul', '596', '93548200', -29.69305, -51.11651, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Imobiliárias';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555133217799', now(), now());
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
        SET v_tag_name = 'IMOBILIARIAS,IMOVEL,IMOVEIS,APARTAMENTOS,APARTAMENTO,CONDOMINIOS,RESIDENCIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'IMOBILIARIAS,IMOVEL,IMOVEIS,APARTAMENTOS,APARTAMENTO,CONDOMINIOS,RESIDENCIAS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'B e B Couros Comércio Repr Ass Técnica', 'b-e-b-couros-comercio-repr-ass-tecnica', 'Centro', 'Rua Júlio de Castilhos', '405 402', '93510130', -29.68182, -51.12731, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Máquinas e Ferramentas';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135939269', now(), now());
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
        SET v_tag_name = 'MAQUINAS E EQUIPAMENTOS INDUSTRIAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MAQUINAS E EQUIPAMENTOS INDUSTRIAIS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Hamburgo- Comercio de Couros  - Canudos', 'hamburgo--comercio-de-couros---canudos', 'Canudos', 'Rua Ícaro', '643', '93544020', -29.68124, -51.08978, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Estética';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135951081', now(), now());
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
        SET v_tag_name = 'ATACADISTAS E FABRICANTES DE ARTEFATOS DE COURO COURO MODA E BELEZA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ATACADISTAS E FABRICANTES DE ARTEFATOS DE COURO COURO MODA E BELEZA', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Eletrônico Citibank 24h - Loja de Conveniencia  Ampm', 'caixa-eletronico-citibank-24h---loja-de-conveniencia-ampm', 'Pátria Nova', 'Avenida Pedro Adams Filho', '4777', '93320006', -29.69046, -51.12886, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bem Estar e Qualidade de Vida', 'bem-estar-e-qualidade-de-vida', 'Rio Branco', 'Rua Vsc. de Taunay', '424', '93310200', -29.68733, -51.1388, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Acupuntura';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Metal Cor Nh Metalização', 'metal-cor-nh-metalizacao', 'Guarani', 'Rua Aparício Borges', '130', '93520060', -29.6688, -51.12897, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Rp Mais', 'rp-mais', 'Guarani', 'Rua Joaquim Pedro Soares', '317', '93510320', -29.6841, -51.12648, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Agência de Relações Públicas';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Escola de Educação Infantil Brincar e Aprender', 'escola-de-educacao-infantil-brincar-e-aprender', 'Guarani', 'Rua São Luiz Gonzaga', '323', '93520540', -29.67271, -51.12779, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Educação Infantil';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135941637', now(), now());
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
        SET v_tag_name = 'EDUCACAO INFANTIL';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'EDUCACAO INFANTIL', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ar Mirco e Filhos - Rio Branco', 'ar-mirco-e-filhos---rio-branco', 'Ideal', 'Avenida Nações Unidas', '1120', '93310500', -29.67961, -51.13794, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135271115', now(), now());
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
        SET v_tag_name = 'DOCES  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'DOCES  ATAC E FAB', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Flexa Nh', 'flexa-nh', 'Mauá', 'Rua Gomes Portinho', '282', '93510360', -29.68601, -51.12594, now(), now());
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
    END IF;
    -- end ad record
    -- begin ad record
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Nilda Duarte Pavani - Guarani', 'nilda-duarte-pavani---guarani', 'Guarani', 'Rua Guajuvira', '351', '93520200', -29.67434, -51.12442, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Consultoria Empresarial';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135939034', now(), now());
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
        SET v_tag_name = 'CONSULTORES DE ORGANIZACAO E METODOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CONSULTORES DE ORGANIZACAO E METODOS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bandebox - Vila Rosa', 'bandebox---vila-rosa', 'Operário', 'Rua Onze de Junho', '525', '93315130', -29.67721, -51.13426, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Banheiro';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130353635', now(), now());
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
        SET v_tag_name = 'BOX PARA BANHEIROS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'BOX PARA BANHEIROS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Matrizaria Ncgravações', 'matrizaria-ncgravacoes', 'Guarani', 'Rua Arlindo Pasqualini', '103', '93525070', -29.66998, -51.12119, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mexx Company Exportadora', 'mexx-company-exportadora', 'Centro', 'Rua João Antônio da Silveira', '42', '93510300', -29.68669, -51.1222, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Informática';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Serviços Gerais - Nova Serviços', 'servicos-gerais---nova-servicos', 'Operário', 'Rua Br. de Rio Branco', '420', '93315330', -29.67192, -51.13551, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Consultoria em Segurança';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Paper Encadernações Ind e Com de Capas - Ideal', 'paper-encadernacoes-ind-e-com-de-capas---ideal', 'Ideal', 'Avenida Vereador Adão Rodrigues de Oliveira', '109', '93334290', -29.6924, -51.14055, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Clínicas Psiquiátricas';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135939439', now(), now());
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
        SET v_tag_name = 'ENCADERNADORES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ENCADERNADORES', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Vale Têxtil', 'vale-textil', 'Rondônia', 'Rua Coronel Jacob Kroeff Fo.', '2346', '93415580', -29.70616, -51.12128, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Americanas Express - Novo Shopping', 'americanas-express---novo-shopping', 'Ideal', 'Avenida Nações Unidas', '2000', '93320021', -29.68613, -51.13302, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Açougues';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '551140034848', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Meller do Brasil Industria de Bolsas  - Mauá', 'meller-do-brasil-industria-de-bolsas---maua', 'Mauá', 'Rua São Jerônimo', '416', '93548190', -29.68967, -51.11716, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135252222', now(), now());
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
        SET v_tag_name = 'ATACADISTAS E FABRICANTES DE MALAS ACESSORIOS MODA E BELEZA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ATACADISTAS E FABRICANTES DE MALAS ACESSORIOS MODA E BELEZA', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Indústria de Calçados Sommavilla  - São José', 'industria-de-calcados-sommavilla---sao-jose', 'São José', 'Rua Farroupilha', '300', '93530500', -29.65991, -51.1116, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135959700', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'In Design - Objetos e Interiores', 'in-design---objetos-e-interiores', 'Rio Branco', 'Avenida Coronel Frederico Linck', '1189', '93336002', -29.69074, -51.131, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135812216', now(), now());
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
        SET v_tag_name = 'Utilidades Domésticas e Objetos de Decoração';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Utilidades Domésticas e Objetos de Decoração', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Indústria de Máquinas e Metal  - Roselândia', 'industria-de-maquinas-e-metal---roselandia', 'Roselândia', 'Rua Floradora', '195', '93351270', -29.64045, -51.13742, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135276895', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ag Lot A Papagaia Ag Lot A Papagaia', 'ag-lot-a-papagaia-ag-lot-a-papagaia', 'Rio Branco', 'Rua Lima E Silva', '426', '93510030', -29.68434, -51.12959, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'A Sofisticação Eo Requinte No Seu Lar', 'a-sofisticacao-eo-requinte-no-seu-lar', 'Ouro Branco', 'Avenida Pedro Adams Fo.', '4727', '93320006', -29.69081, -51.1288, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Revista Projetar', 'revista-projetar', 'Ideal', 'Rua Três de Outubro', '490', '93336130', -29.70061, -51.13744, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Músicos';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Kildare - Rio Branco', 'kildare---rio-branco', 'Rio Branco', 'Rua Marcílio Dias', '684', '93310110', -29.68866, -51.13566, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135937833', now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '35937833', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 2, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Disk Kosméticos', 'disk-kosmeticos', 'Rio Branco', 'Rua Marcílio Dias', '1310', '93410190', -29.68788, -51.12898, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Estética';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135828822', now(), now());
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
        SET v_tag_name = 'DISK';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'DISK', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Tinturaria', 'tinturaria', 'Canudos', 'Rua da Salma Marques', '101', '93546620', -29.70548, -51.10802, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Lavanderias';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130352262', now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '30352262', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 2, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'X-10     Surf & Skate', 'x-10-surf-&-skate', 'Canudos', 'Rua Ícaro', '23', '93544020', -29.67596, -51.08901, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130651979', now(), now());
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
        SET v_tag_name = 'X10 SURF SKATE NOVO HAMBURGO VESTUARIO CALCADOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'X10 SURF SKATE NOVO HAMBURGO VESTUARIO CALCADOS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Pitrez Informatica', 'pitrez-informatica', 'Centro', 'Rua Júlio de Castilhos', '405', '93510130', -29.68182, -51.12731, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Informática';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130367755', now(), now());
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
        SET v_tag_name = 'DBA INFORMATICA CONSULTORIA PLANOS SISTEMAS ERP ORACLE MIGRACAO MIGRACOES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'DBA INFORMATICA CONSULTORIA PLANOS SISTEMAS ERP ORACLE MIGRACAO MIGRACOES', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Wantedshoes', 'wantedshoes', 'Diehl', 'Rua Das Azaléias', '64', '93352440', -29.64238, -51.11928, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Posto Novo Hamburgo', 'posto-novo-hamburgo', 'Ouro Branco', 'Avenida Pedro Adams Fo.', '730', '93320001', -29.7236, -51.13409, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135866042', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Megahartz Informatica  -  - Boa Vista', 'megahartz-informatica-----boa-vista', 'Boa Vista', 'Rua Tamandaré', '86', '93410150', -29.69133, -51.12795, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Informática';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130656660', now(), now());
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
        SET v_tag_name = 'ARTIGOS EQUIPAMENTOS E SUPRIMENTOS PARA INFORMATICA MATERIAIS ARTIGOS E EQUIPAMENTOS INFORMATICA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ARTIGOS EQUIPAMENTOS E SUPRIMENTOS PARA INFORMATICA MATERIAIS ARTIGOS E EQUIPAMENTOS INFORMATICA', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Orquideadecorações - Rio Branco', 'orquideadecoracoes---rio-branco', 'Rio Branco', 'Rua Borges de Medeiros', '146', '93310280', -29.68416, -51.1362, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Jardim e Lazer';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135931111', now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '35931111', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 2, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Outlet Arezzo - Nh', 'outlet-arezzo---nh', 'Rincão', 'Rodovia Br-116', '116', '93340240', -29.67719, -51.14247, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135935454', now(), now());
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
        SET v_tag_name = 'Calçado, Sapato, Sandália, Tenis, Cinto, Bolsa';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Calçado, Sapato, Sandália, Tenis, Cinto, Bolsa', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Itali Industrial Comercial Plásticos  - Ideal', 'itali-industrial-comercial-plasticos---ideal', 'Ideal', 'Rua Dos Pinheiros', '222', '93334190', -29.712, -51.14111, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Plásticos';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135873200', now(), now());
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
        SET v_tag_name = 'PLASTICOS  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'PLASTICOS  ATAC E FAB', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bgk Acessórios', 'bgk-acessorios', 'Canudos', 'Rua Vidal Brasil', '564', '93540090', -29.67968, -51.10579, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135879743', now(), now());
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
        SET v_tag_name = 'Bgk acessórios';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Bgk acessórios', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Eletrônico Bradesco Dia e Noite - Hipermercados Carrefour  Novo Hamburgo  Conveniencia', 'caixa-eletronico-bradesco-dia-e-noite---hipermercados-carrefour-novo-hamburgo-conveniencia', 'Ideal', 'Rua Primeiro de Março', '2711', '93320010', -29.70782, -51.13442, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Info Vision Equipamentos Eletrônicos', 'info-vision-equipamentos-eletronicos', 'Ouro Branco', 'Rua Bento Gonçalves', '888', '93410001', -29.69883, -51.12712, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'X 10', 'x-10', 'Ouro Branco', 'Avenida Pedro Adams Fo.', '5702', '93310560', -29.68252, -51.13029, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135931851', now(), now());
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
        SET v_tag_name = 'ROUPA FEMININA E MASCULINA  ATACADO E FABRICACAO VESTUARIO FEMININAS MASCULINAS ROUPAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ROUPA FEMININA E MASCULINA  ATACADO E FABRICACAO VESTUARIO FEMININAS MASCULINAS ROUPAS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Máquinas Klein S/A Indústria Comércio - São Jorge', 'maquinas-klein-sa-industria-comercio---sao-jorge', 'São Jorge', 'Rua Dezenove de Novembro', '2', '93534490', -29.67164, -51.09868, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Máquinas e Ferramentas';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135249100', now(), now());
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
        SET v_tag_name = 'MAQUINAS E EQUIPAMENTOS INDUSTRIAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MAQUINAS E EQUIPAMENTOS INDUSTRIAIS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'H Dexheimer & Cia Da', 'h-dexheimer-&-cia-da', 'Centro', 'Rua Joaquim Nabuco', '11', '93310001', -29.68589, -51.13714, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Livrarias';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135932914', now(), now());
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
        SET v_tag_name = 'LIVRARIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LIVRARIAS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Eletrônico Banco Real Carref N Hamburgo', 'caixa-eletronico-banco-real-carref-n-hamburgo', 'Industrial', 'Avenida 1 de Marco 2711', null, null, -29.6747, -51.1314, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '558007072399', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Banco 24h Novo Shop', 'banco-24h-novo-shop', 'Ideal', 'Avenida Nações Unidas', '2001', '93320021', -29.68566, -51.1335, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'X-10     Surf & Skate', 'x-10-surf-&-skate', 'Canudos', 'Rua Bartolomeu de Gusmão', '99', '93542000', -29.67668, -51.09731, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135242382', now(), now());
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
        SET v_tag_name = 'X10 SURF SKATE NOVO HAMBURGO VESTUARIO CALCADOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'X10 SURF SKATE NOVO HAMBURGO VESTUARIO CALCADOS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'M&F - Comércio e Representações .', 'm&f---comercio-e-representacoes-.', 'Centro', 'Rua Victor Hugo Kunz', '700', '93510150', -29.67505, -51.11673, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Decoração';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Linguagem Digital - Informática - Guarani', 'linguagem-digital---informatica---guarani', 'Guarani', 'Rua Tavares', '170', '93520520', -29.6732, -51.127, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Marketing Digital';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Dinamica Participações', 'dinamica-participacoes', 'Mauá', 'Rua Gomes Portinho', '17', '93510360', -29.68611, -51.1266, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Empreendimentos';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130668814', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Jrb Consultores Associados', 'jrb-consultores-associados', 'Ouro Branco', 'Avenida Pedro Adams Fo.', '5114', '93320007', -29.6875, -51.12937, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Consultoria Empresarial';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135815270', now(), now());
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
        SET v_tag_name = 'ADVOGADOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ADVOGADOS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Singular Price', 'singular-price', 'Centro', 'Rua Santos Pedroso', '446', '93520340', -29.67718, -51.12, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Informática';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Expositores Batista', 'expositores-batista', 'Canudos', 'Rua Gen. Daltro Filho', '1678', '93540000', -29.67605, -51.10193, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Phoenix Stands- Estandes Para Eventos', 'phoenix-stands--estandes-para-eventos', 'Santo Afonso', 'Rua Santa Clara do Sul', '331', '93425200', -29.71892, -51.12417, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Centros de Convenções';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Aauto Ttrace Cargas e Comercio  - Ouro Branco', 'aauto-ttrace-cargas-e-comercio---ouro-branco', 'Ouro Branco', 'Rua Formosa', '21', '93415060', -29.70711, -51.12902, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Transporte';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130353126', now(), now());
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
        SET v_tag_name = 'TRANSPORTE RODOVIARIO TRANSPORTES TERRESTRES TRANSPORTES ARMAZENAGEM E LOGISTICA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'TRANSPORTE RODOVIARIO TRANSPORTES TERRESTRES TRANSPORTES ARMAZENAGEM E LOGISTICA', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Brivia Gestão Digital e Ti', 'brivia-gestao-digital-e-ti', 'Centro', 'Rua David Canabarro', '20', '93510020', -29.6851, -51.1296, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Marketing Digital';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130550055', now(), now());
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
        SET v_tag_name = 'AGENCIA WEB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'AGENCIA WEB', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Eletrônico Banco Real Shop Bourbon N H', 'caixa-eletronico-banco-real-shop-bourbon-n-h', 'Ideal', 'Rua Primeiro de Março', '1111', '93320010', -29.694, -51.12966, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Novo Hamburgo', 'novo-hamburgo', 'Ideal', 'Avenida Nações Unidas', '2221', '93320021', -29.68744, -51.13277, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Fast Food';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135935451', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Eletrônico Bradesco Dia e Noite - Auto Posto C S', 'caixa-eletronico-bradesco-dia-e-noite---auto-posto-c-s', 'Centro', 'Rua Victor Hugo Kunz', '2345', null, -29.67361, -51.09964, now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bazar Preta e Branca', 'bazar-preta-e-branca', 'Centro', 'Rua Jose Arnoldo Klaus 60 Sl 03', '1', '09370000', -29.6801, -51.1293, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Bazares';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130381964', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Sander Auto Eletrica', 'sander-auto-eletrica', 'Centro', 'Avenida F Bibiano Trott 105', '1', '09370000', -29.6801, -51.1293, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135972548', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Avaliações de Imóveis e Perícias, Cristiano Fleck', 'avaliacoes-de-imoveis-e-pericias--cristiano-fleck', 'Ideal', 'Avenida Nações Unidas', '2456', '93320020', -29.6901, -51.13266, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Imobiliárias';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130356635', now(), now());
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
        SET v_tag_name = 'avaliação de imoveis, perito, avaliador, imovel';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'avaliação de imoveis, perito, avaliador, imovel', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Excelsior Pneus', 'excelsior-pneus', 'Ideal', 'Avenida Nações Unidas', '3100', '93320020', -29.69578, -51.13382, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Pneus';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135812233', now(), now());
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
        SET v_tag_name = 'PIRELLI PNEUS REVENDA AUTORIZADA P600 P400 P2000 P3000 P6000 MT40 MT60 MT65 MT75 MT90 PIRELI PIRELE PIRELLE PENEU PNEU PNEUS PENEUS RODA RODAS BORRACHEIRO BORRACHARIA REVENDA REVENDEDOR PIRELLIPNEUS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'PIRELLI PNEUS REVENDA AUTORIZADA P600 P400 P2000 P3000 P6000 MT40 MT60 MT65 MT75 MT90 PIRELI PIRELE PIRELLE PENEU PNEU PNEUS PENEUS RODA RODAS BORRACHEIRO BORRACHARIA REVENDA REVENDEDOR PIRELLIPNEUS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ls Assessoria Empresarial', 'ls-assessoria-empresarial', 'Operário', 'Rua Vsc. de Ouro Preto', '20', '93315400', -29.6719, -51.13405, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Consultoria de Organização e Métodos';
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'J J Martins', 'j-j-martins', 'Rincão', 'Rua Rincão', '1890', '93310460', -29.66947, -51.15606, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Construção';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135957554', now(), now());
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
        SET v_tag_name = 'MATERIAIS DE CONSTRUCAO  LOJAS MATERIAL DE CONSTRUCAO CONSTRUCOES DEPOSITO DEPOSITOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MATERIAIS DE CONSTRUCAO  LOJAS MATERIAL DE CONSTRUCAO CONSTRUCOES DEPOSITO DEPOSITOS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Vilsom Vanderlei Affonso - Rondônia', 'vilsom-vanderlei-affonso---rondonia', 'Rondônia', 'Rua João Wendelino Hennemann', '443', '93415700', -29.70017, -51.12006, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135827542', now(), now());
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
        SET v_tag_name = 'PADARIAS E CONFEITARIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'PADARIAS E CONFEITARIAS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Posto Malufe  R Engenheiro Jorge Schury', 'posto-malufe-r-engenheiro-jorge-schury', 'São José', 'Rua Engenheiro Jorge Schury', '1393', '93534040', -29.66162, -51.10847, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '5555515874903', now(), now());
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
        SET v_tag_name = 'POSTO BANDEIRA BRANCA R ENGENHEIRO JORGE SCHURY ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'POSTO BANDEIRA BRANCA R ENGENHEIRO JORGE SCHURY ', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Golfinho', 'golfinho', 'Rio Branco', 'Rua Saldanha Marinho', '176', '93320060', -29.69006, -51.13066, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Esportes';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135931627', now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '35931627', now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdPhoneMax;
        FETCH cursorAdPhoneMax INTO v_ad_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_phone_id_max = null;
        END IF;
        CLOSE cursorAdPhoneMax;
        SET v_ad_phone_id_max = v_ad_phone_id_max + 1;
        INSERT INTO AD_PHONE_TBL(id, ad_id, phone_id, sequence, created_at, updated_at) VALUES(v_ad_phone_id_max, v_ad_id_max, v_phone_id_max, 2, now(), now());
    END IF;
    -- end ad record
    -- begin ad record
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Feeling Sul Ind e Com', 'feeling-sul-ind-e-com', 'Rio Branco', 'Rua Marcílio Dias', '511', '93310110', -29.68889, -51.13741, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135828111', now(), now());
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
        SET v_tag_name = 'REFRIGERACAO  ART EQUIP E CONSERTO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'REFRIGERACAO  ART EQUIP E CONSERTO', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Posto Triangulo  R Marques de Souza', 'posto-triangulo-r-marques-de-souza', 'São José', 'Rua Mq. de Souza', '843', '93534010', -29.6659, -51.10852, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555151524338', now(), now());
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
        SET v_tag_name = 'POSTO BANDEIRA BRANCA R MARQUES DE SOUZA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'POSTO BANDEIRA BRANCA R MARQUES DE SOUZA', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Otávio Beno da Silva - São José', 'otavio-beno-da-silva---sao-jose', 'São José', 'Rua Engenheiro Jorge Schury', '592', '93534040', -29.66864, -51.10619, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135248899', now(), now());
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
        SET v_tag_name = 'ARMAZENS GERAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ARMAZENS GERAIS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Breunig Advogados Associados', 'breunig-advogados-associados', 'Ouro Branco', 'Rua Bento Gonçalves', '1731', '93410003', -29.69154, -51.12678, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Advogados';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135273913', now(), now());
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
        SET v_tag_name = 'ADVOGADOS                                                        ADVOGADOS CONSULTORES E PROFISSIONAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ADVOGADOS                                                        ADVOGADOS CONSULTORES E PROFISSIONAIS', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Cyntia Rumi Igari', 'cyntia-rumi-igari', 'Ouro Branco', 'Rua Bento Gonçalves', '1945', '93410003', -29.68963, -51.12693, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '5555515943201', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Auto Posto Ideal Esso Avenida Sete de Setembro', 'auto-posto-ideal-esso-avenida-sete-de-setembro', 'Industrial', 'Rua Sete de Setembro', '274', '93332470', -29.71307, -51.14462, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '5555515875212', now(), now());
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
        SET v_tag_name = 'POSTO ESSO AVENIDA SETE DE SETEMBRO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'POSTO ESSO AVENIDA SETE DE SETEMBRO', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Comercial de Combustiveis Wilsmann  Shell Avenida Pedro Adams Filh', 'comercial-de-combustiveis-wilsmann-shell-avenida-pedro-adams-filh', 'Ouro Branco', 'Avenida Pedro Adams Fo.', '1555', '93320001', -29.71828, -51.12886, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '5555515945700', now(), now());
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
        SET v_tag_name = 'POSTO SHELL AVENIDA PEDRO ADAMS FILHO ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'POSTO SHELL AVENIDA PEDRO ADAMS FILHO ', now(), now());
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
    SET v_city_name_uri = 'novo-hamburgo';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Eficácia Assessoria Empresarial', 'eficacia-assessoria-empresarial', 'Ouro Branco', 'Rua Bento Gonçalves', '841', '93410001', -29.69942, -51.12716, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Assessoria Empresarial';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130666333', now(), now());
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
END;
//
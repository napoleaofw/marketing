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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Liga Feminina de Combate Ao Câncer de Dois Irmãos', 'liga-feminina-de-combate-ao-cancer-de-dois-irmaos', 'Centro', 'Avenida São Miguel', '900', null, -29.58463, -51.08703, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645622', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Luiz Felippe Wittmann - Travessão', 'luiz-felippe-wittmann---travessao', 'Travessão', 'Rodovia Br-116', 's/n', null, -29.62056, -51.12503, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Serviços Sociais';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642456', now(), now());
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
        SET v_tag_name = 'SERVICOS SOCIAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SERVICOS SOCIAIS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Enzweiler Instalações Elétricas Sanitárias', 'enzweiler-instalacoes-eletricas-sanitarias', 'Centro', 'Avenida Irineu Becker', '625', null, -29.57896, -51.09395, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641699', now(), now());
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
        SET v_tag_name = 'INSTALACOES ELETRICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'INSTALACOES ELETRICAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Procuradoria Geral da Justiça', 'procuradoria-geral-da-justica', 'Centro', 'Rua Germano Hauschild', '18', null, -29.58314, -51.08796, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641600', now(), now());
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
        SET v_tag_name = 'ORGAOS PUBLICOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ORGAOS PUBLICOS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Gueto Ecodesing de Produto - Travessão', 'gueto-ecodesing-de-produto---travessao', 'Travessão', 'Rodovia Br-116', 's/n', null, -29.62056, -51.12503, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Design';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643131', now(), now());
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
        SET v_tag_name = 'DESIGN';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'DESIGN', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Lidiana Schneider', 'lidiana-schneider', 'Centro', 'Rua Renato Vier', '308', null, -29.57047, -51.09392, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Som e Vídeo';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135647060', now(), now());
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
        SET v_tag_name = 'VIDEOCLUBES E LOCADORAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'VIDEOCLUBES E LOCADORAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Accurato Indústria e Comércio de Couros - Travessão', 'accurato-industria-e-comercio-de-couros---travessao', 'Travessão', 'Rod. Br-116', '620', null, -29.56479, -51.09192, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135647678', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Coleta Maria Schuh Alles - Travessão', 'coleta-maria-schuh-alles---travessao', 'Travessão', 'Rua Assis', '63 nr 1072', null, -29.62232, -51.12009, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645653', now(), now());
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
        SET v_tag_name = 'GALVANIZACAO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'GALVANIZACAO', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Rosa D Agua', 'rosa-d-agua', 'Centro', 'Avenida Vinte E Cinco de Julho', '571', '93950000', -29.58317, -51.08774, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645897', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Loja Colombo - Dois Irmaos - Centro', 'loja-colombo---dois-irmaos---centro', 'Centro', 'Avenida São Miguel', '1210', null, -29.5819, -51.0866, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '558007414141', now(), now());
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
        SET v_tag_name = 'TIM LOJA TIM CELULAR TELEFONIA E TELECOMUNICACOES TELEFONIA AGENTE DISTRIBUIDOR DE RECARGA SETOR D';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'TIM LOJA TIM CELULAR TELEFONIA E TELECOMUNICACOES TELEFONIA AGENTE DISTRIBUIDOR DE RECARGA SETOR D', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Darcy Wagner e Cia  - Primavera', 'darcy-wagner-e-cia---primavera', 'Primavera', 'Rua Novo Hamburgo', '155', null, -29.57515, -51.09253, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642228', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Al Wittimann & Cia', 'al-wittimann-&-cia', 'Centro', 'Tv Pst Prutsckin', '42', null, -29.58283, -51.08715, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641623', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Calçados Maide  - Floresta', 'calcados-maide---floresta', 'Floresta', 'Rua Sto. Antônio da Patrulha', '400', null, -29.57684, -51.08876, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135648200', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Arceliro Schumacher', 'arceliro-schumacher', 'Centro', 'Rua S Miguel', '2221', null, -29.59122, -51.08812, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Corretores de seguros';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642337', now(), now());
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
        SET v_tag_name = 'SEGUROS  CORRETORES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'SEGUROS  CORRETORES', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Maria da Conceicao Scherer', 'maria-da-conceicao-scherer', 'Centro', 'Avenida Dez de Setembro', '1333', null, -29.58083, -51.08521, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641710', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Altamir Berro Bordin', 'altamir-berro-bordin', 'Centro', 'Avenida Do Parque', '1401', null, -29.58114, -51.09189, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644788', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Produtos Specht', 'produtos-specht', 'Centro', 'Rua 29 de Setembro', '241', null, -29.57208, -51.08442, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641008', now(), now());
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
        SET v_tag_name = 'MASSAS ALIMENTICIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MASSAS ALIMENTICIAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Henrich & Cia', 'henrich-&-cia', 'Centro', 'Avenida São Miguel', '1051', null, -29.5833, -51.08682, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641555', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Maria Jandira Vier', 'maria-jandira-vier', 'Centro', 'Rua S Miguel', '969 s 1', null, -29.5803, -51.08646, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642122', now(), now());
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
        SET v_tag_name = 'CONFECCOES MASCULINAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CONFECCOES MASCULINAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Neuri Altenhofen', 'neuri-altenhofen', 'Centro', 'Avenida Vinte E Cinco de Julho', '1200', null, -29.57787, -51.08681, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645927', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Vale Serra Construções', 'vale-serra-construcoes', 'Centro', 'Avenida Vinte E Cinco de Julho', '470 1', null, -29.58386, -51.08791, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641416', now(), now());
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
        SET v_tag_name = 'CONSTRUTORAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CONSTRUTORAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Centropé Ind. de Calçados .', 'centrope-ind.-de-calcados-.', 'Primavera', 'Rua Novo Hamburgo', '1056', '93950000', -29.58003, -51.09277, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641888', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Minimercado Beira Rio  - Beira Rio', 'minimercado-beira-rio---beira-rio', 'Beira Rio', 'Avenida João Klauck', '700', null, -29.59091, -51.09538, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642280', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Flores & Backes Indústria de Calçados', 'flores-&-backes-industria-de-calcados', 'Centro', 'Avenida Dez de Setembro', '110 fd', null, -29.59268, -51.08736, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135647033', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Auto Nova Petrópolis - Travessão', 'auto-nova-petropolis---travessao', 'Travessão', 'Rodovia Br-116', '6140', null, -29.62056, -51.12503, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642300', now(), now());
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
        SET v_tag_name = 'AUTOMOVEIS  REVENDEDORES E CONCESSIONARIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'AUTOMOVEIS  REVENDEDORES E CONCESSIONARIAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Lancheria Bom Gosto', 'lancheria-bom-gosto', 'Centro', 'Rua 10 de Setembro', '1763', null, -29.58655, -51.08624, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646278', now(), now());
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
        SET v_tag_name = 'LANCHONETES RESTAURANTES ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LANCHONETES RESTAURANTES ', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Opção Foto e Vídeo', 'opcao-foto-e-video', 'Centro', 'Rua S Miguel', '900 s 4', null, -29.57969, -51.08635, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644841', now(), now());
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
        SET v_tag_name = 'FOTOGRAFIAS  AMPLIACOES COPIAS E REVELACOES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FOTOGRAFIAS  AMPLIACOES COPIAS E REVELACOES', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Volnei Luiz Melara', 'volnei-luiz-melara', 'Centro', 'Avenida São Miguel', '575', null, -29.58755, -51.08757, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641132', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Marta Rosângela Zucolotto', 'marta-rosangela-zucolotto', 'Centro', 'Rua Irineu Becker', '254', null, -29.57928, -51.0932, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646358', now(), now());
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
        SET v_tag_name = 'LANCHES  FORNECIMENTO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LANCHES  FORNECIMENTO', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Sociedade de Educação e Caridade', 'sociedade-de-educacao-e-caridade', 'Centro', 'Rua S Miguel', '482', null, -29.57608, -51.08567, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641783', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Iara M Z Wickert', 'iara-m-z-wickert', 'Centro', 'Avenida São Miguel', '939', null, -29.58431, -51.08697, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644909', now(), now());
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
        SET v_tag_name = 'CONFECCOES  REPRESENTACOES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CONFECCOES  REPRESENTACOES', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Raed Rajeh Mohd Abde', 'raed-rajeh-mohd-abde', 'Centro', 'Avenida Irineu Becker', '152', '93950000', -29.58076, -51.08802, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646240', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Eletrônico Banco Bradesco - Calcados Maide Ltda. ,Dois Irmaos', 'caixa-eletronico-banco-bradesco---calcados-maide-ltda.--dois-irmaos', 'Centro', 'Rua Santo Antônio da Patrulha', '400', '93950000', -29.57684, -51.08876, now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Unimed Vale dos Sinos Cooperativa de Trabalho Médico', 'unimed-vale-dos-sinos-cooperativa-de-trabalho-medico', 'Centro', 'Avenida São Miguel', '900 2', null, -29.58463, -51.08703, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Assistência Médica';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645533', now(), now());
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
        SET v_tag_name = 'ASSISTENCIA MEDICA E ODONTOLOGICA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ASSISTENCIA MEDICA E ODONTOLOGICA', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Laboratório Dois Irmãos', 'laboratorio-dois-irmaos', 'Centro', 'Rua S Miguel', '575 s 3', null, -29.57698, -51.08584, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641680', now(), now());
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
        SET v_tag_name = 'LABORATORIOS DE ANALISES CLINICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LABORATORIOS DE ANALISES CLINICAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Oab-Ordem dos Advogados do Brasil-Subseção de Novo Hamburgo - Primaver', 'oab-ordem-dos-advogados-do-brasil-subsecao-de-novo-hamburgo---primaver', 'Primavera', 'Rua Novo Hamburgo', '1079 S', null, -29.58296, -51.09405, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Conselhos de Classe Profissionais';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643881', now(), now());
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
        SET v_tag_name = 'CONSELHOS DE CLASSE PROFISSIONAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CONSELHOS DE CLASSE PROFISSIONAIS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Atelier Beneficiamento Calçados Dino - Primavera', 'atelier-beneficiamento-calcados-dino---primavera', 'Primavera', 'Rua Novo Hamburgo', '492', null, -29.58326, -51.09444, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643028', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Js Lanches', 'js-lanches', 'Centro', 'Rua Renato Vier', '268', null, -29.57052, -51.09357, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646248', now(), now());
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
        SET v_tag_name = 'LANCHONETES RESTAURANTES ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LANCHONETES RESTAURANTES ', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ivete Dickel', 'ivete-dickel', 'Centro', 'Avenida Vinte E Cinco de Julho', '522', null, -29.5834, -51.08783, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644387', now(), now());
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
        SET v_tag_name = 'ROUPAS FEMININAS  LOJAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ROUPAS FEMININAS  LOJAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Audiomed', 'audiomed', 'Centro', 'Avenida Sapiranga', '30', '93950000', -29.58811, -51.08627, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Serviços Médicos e Consultórios';
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Viasinos Calçados', 'viasinos-calcados', 'Centro', 'Rua Irineu Becker', '724', null, -29.58056, -51.0887, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646085', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Escola Prof Carlos Rausch', 'escola-prof-carlos-rausch', 'Centro', 'Rua Onze Amigos', '950', null, -29.5647, -51.07851, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644672', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bar e Lancheria Luismauri   - Canudos', 'bar-e-lancheria-luismauri---canudos', 'Canudos', 'Rua Ícaro', '1886', null, -29.63951, -51.08415, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555130667437', now(), now());
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
        SET v_tag_name = 'LOJAS DE BEBIDAS BEBIDAS ALIMENTOS E BEBIDAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LOJAS DE BEBIDAS BEBIDAS ALIMENTOS E BEBIDAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Sul Gás - Beira Rio', 'sul-gas---beira-rio', 'Beira Rio', 'Avenida João Klauck', '927', null, -29.59065, -51.0972, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Fornecedores e Distribuidores de Gás';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135647437', now(), now());
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
        SET v_tag_name = 'GAS  FORNECEDORES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'GAS  FORNECEDORES', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Dois Irmãos Serviço de Registros Públicos - Floresta', 'dois-irmaos-servico-de-registros-publicos---floresta', 'Floresta', 'Rua Esteio', '340', null, -29.57763, -51.0878, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Cartórios e Tabeliães';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641341', now(), now());
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
        SET v_tag_name = 'CARTORIOS E TABELIAES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CARTORIOS E TABELIAES', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Serra Vile Residencial e Spa Geriatrico', 'serra-vile-residencial-e-spa-geriatrico', 'Uniao', 'Travessa Cento e Cinquenta e Seis', '250', '93950000', -29.59888, -51.09135, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Serviços Médicos e Consultórios';
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Shalom Modas', 'shalom-modas', 'Centro', 'Rua Navegantes', '778', '93950000', -29.58011, -51.09555, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135647323', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ieda Maria Kasper da Silva', 'ieda-maria-kasper-da-silva', 'Centro', 'Avenida Vinte E Cinco de Julho', '133', null, -29.58701, -51.08843, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644889', now(), now());
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
        SET v_tag_name = 'BAZARES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'BAZARES', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Doce Favo', 'doce-favo', 'Centro', 'Avenida Dez de Setembro', '494', '93950000', -29.58852, -51.0866, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644517', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Tm Schneider Transporte e Turismo  - Canudos', 'tm-schneider-transporte-e-turismo---canudos', 'Canudos', 'Rua Bolívia', '1152', null, -29.58415, -51.11813, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135952235', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Prefeitura Municipal de Dois Irmãos', 'prefeitura-municipal-de-dois-irmaos', 'Centro', 'Rua Berlin', '240', null, -29.58929, -51.09028, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641277', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Geittenes Gás - Industrial', 'geittenes-gas---industrial', 'Industrial', 'Avenida Sapiranga', '807', null, -29.58919, -51.07832, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Fornecedores e Distribuidores de Gás';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645766', now(), now());
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
        SET v_tag_name = 'GAS  FORNECEDORES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'GAS  FORNECEDORES', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'José N Olbermann', 'jose-n-olbermann', 'Centro', 'Rua Cambará do Sul', '182', null, -29.57624, -51.08248, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643447', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Rinje V Hattem', 'rinje-v-hattem', 'Centro', 'Avenida Dez de Setembro', '1180', null, -29.58273, -51.08557, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Engenharia Civil';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641274', now(), now());
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
        SET v_tag_name = 'ENGENHEIROS CIVIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ENGENHEIROS CIVIS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Jangs Confecções', 'jangs-confeccoes', 'Centro', 'Avenida Irineu Becker', '282 4', null, -29.58037, -51.08938, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645001', now(), now());
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
        SET v_tag_name = 'MALHAS  ATAC E FAB';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MALHAS  ATAC E FAB', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Criativa', 'criativa', 'Centro', 'Rodovia Br-116', null, '93950000', -29.62056, -51.12503, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555499821955', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'G5 Indústria Comércio Importação e Exportação - Travessão', 'g5-industria-comercio-importacao-e-exportacao---travessao', 'Travessão', 'Rodovia Br-116', 's/n km 229', null, -29.62056, -51.12503, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Importação e Exportação - Assessoria';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135647552', now(), now());
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
        SET v_tag_name = 'IMPORTACAO E EXPORTACAO  ASSESSORIA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'IMPORTACAO E EXPORTACAO  ASSESSORIA', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Henzikar Auto Rede', 'henzikar-auto-rede', 'Centro', 'Avenida Florestal', null, '93950000', -29.58113, -51.08999, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642075', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Supermercado Baggio - Centro - Dois Lajeados', 'supermercado-baggio---centro---dois-lajeados', 'Centro', 'Rua Carlos Gomes', '415', '99220000', -29.58714, -51.07782, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555434711062', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Juarez da Silva Patrício - Bela Vista', 'juarez-da-silva-patricio---bela-vista', 'Bela Vista', 'Rua Anita Garibaldi', '351', null, -29.57986, -51.09872, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641739', now(), now());
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
        SET v_tag_name = 'GRAFICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'GRAFICAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Padaria e Confeitaria Schneider', 'padaria-e-confeitaria-schneider', 'Centro', 'Avenida Vinte E Cinco de Julho', '1621', null, -29.5731, -51.08572, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641411', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Sindicato dos Trabalhadores Nas Indústrias de Calçados de Dois Irmãos', 'sindicato-dos-trabalhadores-nas-industrias-de-calcados-de-dois-irmaos', 'Centro', 'Avenida Florestal', '924', null, -29.58621, -51.0903, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646524', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Funilaria Tks', 'funilaria-tks', '-', 'Avenida S. Miguel', '1838', null, -29.57641, -51.08566, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641444', now(), now());
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
        SET v_tag_name = 'LOJAS DE CALHAS E RUFOS INSUMOS CONSTRUCAO CIVIL  ACABAMENTOS E INSUMOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'LOJAS DE CALHAS E RUFOS INSUMOS CONSTRUCAO CIVIL  ACABAMENTOS E INSUMOS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mercado Irmãos Schmitz', 'mercado-irmaos-schmitz', 'Centro', 'Avenida Vinte E Cinco de Julho', '739', null, -29.58172, -51.08746, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642317', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mundi Calçados', 'mundi-calcados', 'Centro', 'Avenida São Miguel', '819', null, -29.58535, -51.08716, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646600', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ernani Jorge Petry', 'ernani-jorge-petry', 'Centro', 'Rua 10 de Setembro', '2237', null, -29.59067, -51.08702, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Despachantes';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641342', now(), now());
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
        SET v_tag_name = 'DESPACHANTES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'DESPACHANTES', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Maria Klaske Confecções', 'maria-klaske-confeccoes', 'Centro', 'Rua S Miguel', '421', null, -29.57557, -51.08557, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646747', now(), now());
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
        SET v_tag_name = 'CONFECCOES FEMININAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CONFECCOES FEMININAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Sociedade Cultural e Esportiva 7 de Setembro', 'sociedade-cultural-e-esportiva-7-de-setembro', 'Centro', 'Rua Canoas', '377', null, -29.58038, -51.08414, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Estádios';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644141', now(), now());
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
        SET v_tag_name = 'CLUBES E ESTADIOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CLUBES E ESTADIOS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Preservar Trat Reciclagem Resíduos  - São João', 'preservar-trat-reciclagem-residuos---sao-joao', 'São João', 'Estrada Campo Bom', '699 km 2', null, -29.5969, -51.07149, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Reciclagem de Materiais';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645751', now(), now());
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
        SET v_tag_name = 'RECICLAGEM DE MATERIAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'RECICLAGEM DE MATERIAIS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Alice Maria Fink - Primavera', 'alice-maria-fink---primavera', 'Primavera', 'Rua Novo Hamburgo', '111', null, -29.58678, -51.09559, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641538', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Cachaça Dom Braga - Travessão', 'cachaca-dom-braga---travessao', 'Travessão', 'Rua Alberto Rubenich', '4765', null, -29.62587, -51.10346, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641223', now(), now());
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
        SET v_tag_name = 'CACHACAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CACHACAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Yeda Modas', 'yeda-modas', 'Centro', 'Avenida Dez de Setembro', '1605', '93950000', -29.5784, -51.08476, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641551', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Abastecedora de Combustíveis Irmãos Fuhr', 'abastecedora-de-combustiveis-irmaos-fuhr', 'Industrial', 'Avenida Sapiranga', '500', null, -29.58876, -51.08158, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646305', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Coml Construção  Vier', 'coml-construcao-vier', 'Centro', 'Br. 116', '222', null, -29.59367, -51.10796, now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Rs Ferramentas e Máquinas', 'rs-ferramentas-e-maquinas', 'Centro', 'Rua S Miguel', '2312 sl 1', null, -29.592, -51.08825, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Equipamentos para Construção';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643700', now(), now());
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
        SET v_tag_name = 'FERRAMENTAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FERRAMENTAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Centro de Fisioterapia', 'centro-de-fisioterapia', 'Centro', 'Rua Berlin', '215', null, -29.5893, -51.09003, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Clínicas de Fisioterapia';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645128', now(), now());
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
        SET v_tag_name = 'CLINICAS DE FISIOTERAPIA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CLINICAS DE FISIOTERAPIA', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Escola Est Ens Fun Joao Grawer Filho', 'escola-est-ens-fun-joao-grawer-filho', 'Centro', 'Rua Albano Schuh', '106', '93950000', -29.62039, -51.12743, now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'A Blume-Eletro Mecânica', 'a-blume-eletro-mecanica', 'Centro', 'Avenida Vinte E Cinco de Julho', '1201', null, -29.57764, -51.08677, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642128', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Clube Diretores Lojistas de Dois Irmãos', 'clube-diretores-lojistas-de-dois-irmaos', 'Centro', 'Rua S Miguel', '667', null, -29.57797, -51.08603, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642200', now(), now());
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
        SET v_tag_name = 'CAMARAS DE COMERCIO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CAMARAS DE COMERCIO', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mecânica Nico  - Beira Rio', 'mecanica-nico---beira-rio', 'Beira Rio', 'Avenida João Klauck', '768', null, -29.59081, -51.096, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644477', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Erva Doce Confecções', 'erva-doce-confeccoes', 'Centro', 'Rua Otto Engelmann', '83 s 1', null, -29.58142, -51.08652, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641246', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Salão e Estética New Look', 'salao-e-estetica-new-look', 'Centro', 'Avenida Porto Alegre', '381', null, -29.59001, -51.08551, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643376', now(), now());
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
        SET v_tag_name = 'CLINICAS DE ESTETICA';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'CLINICAS DE ESTETICA', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Rodrisa Informática', 'rodrisa-informatica', 'Centro', 'Avenida Vinte E Cinco de Julho', '885', null, -29.58033, -51.08723, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Cursos e Aulas Particulares';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644455', now(), now());
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
        SET v_tag_name = 'INFORMATICA  CURSOS E TREINAMENTO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'INFORMATICA  CURSOS E TREINAMENTO', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Mini Mercado Franciele', 'mini-mercado-franciele', 'Centro', 'Avenida Porto Alegre', '15', null, -29.59533, -51.08654, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645101', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Pronto Óptica e Relojoaria', 'pronto-optica-e-relojoaria', 'Centro', 'Avenida São Miguel', '905', null, -29.58461, -51.08703, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641658', now(), now());
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
        SET v_tag_name = 'RELOJOARIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'RELOJOARIAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Estado Rgs Procur Geral de Just Prom de Just de São Jerônimo', 'estado-rgs-procur-geral-de-just-prom-de-just-de-sao-jeronimo', 'Centro', 'Tv Germano Hauschild', '18', null, -29.58313, -51.08795, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641600', now(), now());
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
        SET v_tag_name = 'ADMINISTRACOES REGIONAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'ADMINISTRACOES REGIONAIS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Chuletão Casa de Carnes', 'chuletao-casa-de-carnes', 'Centro', 'Avenida Dez de Setembro', '1249', null, -29.58153, -51.08534, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644380', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Fórum de Dois Irmãos - Primavera', 'forum-de-dois-irmaos---primavera', 'Primavera', 'Rua Novo Hamburgo', '1079', null, -29.58296, -51.09405, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641487', now(), now());
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
        SET v_tag_name = 'FORUNS E TRIBUNAIS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'FORUNS E TRIBUNAIS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Central de Pinturas', 'central-de-pinturas', 'Centro', 'Avenida São Miguel', '1506', '93950000', -29.57929, -51.08617, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643595', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Corsan-Companhia Riograndense de Saneamento - Industrial', 'corsan-companhia-riograndense-de-saneamento---industrial', 'Industrial', 'Avenida Sapiranga', 's/n s 2', null, -29.58812, -51.08653, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641767', now(), now());
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
        SET v_tag_name = 'AGUA E ESGOTOS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'AGUA E ESGOTOS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Unidade de Saúde Sao Joao Dirmaos', 'unidade-de-saude-sao-joao-dirmaos', 'Sao Joao', 'Rua Minas Gerais', 's/n', '93950000', -29.59974, -51.07967, now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Irmãos Hoffmeister', 'irmaos-hoffmeister', 'Centro', 'Avenida S. Miguel', '1705', null, -29.57759, -51.0859, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641840', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Policopy Gráfica Digital', 'policopy-grafica-digital', 'Centro', 'Rua Otto Engelmann', '83 4', null, -29.58155, -51.0858, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646197', now(), now());
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
        SET v_tag_name = 'COPIAS XEROGRAFICAS E HELIOGRAFICAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'COPIAS XEROGRAFICAS E HELIOGRAFICAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Rota Brasil Agência de Viagem e Turismo', 'rota-brasil-agencia-de-viagem-e-turismo', 'Centro', 'Rua Otto Engelmann', '83 3', null, -29.58155, -51.0858, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Agências de Turismo';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641643', now(), now());
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
        SET v_tag_name = 'TURISMO  AGENCIAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'TURISMO  AGENCIAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Hr Comercial', 'hr-comercial', 'Centro', 'Rua S Miguel', '1569', null, -29.58556, -51.08719, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Produtos de Agricultura e Pecuária';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135647604', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Matadouro de Aves Avesul', 'matadouro-de-aves-avesul', 'Centro', 'Avenida Irineu Becker', '215', null, -29.58052, -51.08848, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641906', now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Agência dos Correios - Agc Dois Irmaos das Missoes - Agencia Correio Comunitaria', 'agencia-dos-correios---agc-dois-irmaos-das-missoes---agencia-correio-comunitaria', 'Centro', 'Rua Sete de Setembro', '07', '98385970', -29.58034, -51.08629, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555537511054', now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555537510230', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Praca Lanches', 'praca-lanches', 'Centro', 'Avenida Vinte E Cinco de Julho', '111', '93950000', -29.5872, -51.08846, now(), now());
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
        SET v_cursor_not_found = FALSE;
        OPEN cursorPhoneMax;
        FETCH cursorPhoneMax INTO v_phone_id_max;
        IF v_cursor_not_found THEN
            SET v_phone_id_max = null;
        END IF;
        CLOSE cursorPhoneMax;
        SET v_phone_id_max = v_phone_id_max + 1;
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555505135645', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Alice R Singler', 'alice-r-singler', 'Jd Dois Irmaos', 'Rua Albano Hansen', '269', '93950000', -29.62191, -51.11687, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643188', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Jk Colocadora de Esquadrias', 'jk-colocadora-de-esquadrias', 'Jd Dois Irmaos', 'Rua Albano Hansen', '642', '93950000', -29.62532, -51.11744, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641855', now(), now());
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
        SET v_tag_name = 'MARCENARIAS MARCENEIROS CARPINTARIA CARPINTEIRO MOVEIS SOB MEDIDA MOVEIS PLANEJADOS MOVEIS MODULADOS MOVEIS PROJETADOS MARCENEIRO MARCENARIA MADEIRA MADEIRAS';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'MARCENARIAS MARCENEIROS CARPINTARIA CARPINTEIRO MOVEIS SOB MEDIDA MOVEIS PLANEJADOS MOVEIS MODULADOS MOVEIS PROJETADOS MARCENEIRO MARCENARIA MADEIRA MADEIRAS', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Dr Vet', 'dr-vet', 'Centro', 'V do Parque 1161', '1', '09395000', -29.5846, -51.0924, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Produtos de Agricultura e Pecuária';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643747', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Ladislau Cochlar Jr', 'ladislau-cochlar-jr', 'Centro', 'Avenida Vinte E Cinco de Julho', '244', '93950000', -29.58585, -51.08828, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135642255', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Marcenaria Maijomarandan', 'marcenaria-maijomarandan', 'Alto da Riviera', 'Rua Prca. Isabel', '145', '93950000', -29.6242, -51.09224, now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Caixa Eletrônico Bradesco Dia e Noite - Dois Irmaos', 'caixa-eletronico-bradesco-dia-e-noite---dois-irmaos', 'Centro', 'Avenida Vinte E Cinco de Julho', 's/n', null, -29.58095, -51.08734, now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Comercio de Material de Treinamento', 'comercio-de-material-de-treinamento', 'Industrial', 'Rua São José', '53', '93950000', -29.58843, -51.08733, now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Treinamentos Brasil', 'treinamentos-brasil', 'Centro', 'Centro da Cidade', '784', '93950000', -29.58147, -51.09396, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Cursos e Aulas Particulares';
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Www.Caoaprendiz.Com.Br', 'www.caoaprendiz.com.br', 'Picada 48', 'Rua Vitória', '82', '93950000', -29.58038, -51.1078, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Canis';
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Dom Joan Criações Em Madeira', 'dom-joan-criacoes-em-madeira', 'Industrial', 'Rua Sede Campestre', '155', '93950000', -29.59036, -51.0785, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Cosméticos';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645569', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Dois Irmãos Desentupidora e Limpa Fossa (51)93989830', 'dois-irmaos-desentupidora-e-limpa-fossa-(51)93989830', 'Centro', 'Centro', '0', null, -29.589, -51.09103, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555193989830', now(), now());
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
        SET v_tag_name = 'desentupidora,limpa fossa';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'desentupidora,limpa fossa', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Desentupidora  Dois Irmãos 24h(51)96644401', 'desentupidora-dois-irmaos-24h(51)96644401', 'Centro', 'Centro', '0', null, -29.589, -51.09103, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555196644401', now(), now());
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
        SET v_tag_name = 'desentupidora,limpa fossa';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'desentupidora,limpa fossa', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Limpa Fossa Dois Irmãos 24h(51)84116530', 'limpa-fossa-dois-irmaos-24h(51)84116530', 'Centro', 'Centro', '0', null, -29.589, -51.09103, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555184116530', now(), now());
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
        SET v_tag_name = 'Desentupidora e Limpa Fossa';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Desentupidora e Limpa Fossa', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Zona Eleitoral - 153 - Centro', 'zona-eleitoral---153---centro', 'Centro', 'Rua 10 de Setembro', '831', '93950000', -29.57844, -51.08483, now(), now());
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
    SET v_country_acronym = null;
    SET v_state_acronym = null;
    SET v_city_name_uri = null;
    SET v_category_name = null;
    SET v_tag_name = null;
    SET v_country_id = null;
    SET v_state_id = null;
    SET v_city_id = null;
    SET v_category_id = null;
    SET v_category_id_exists = null;
    SET v_tag_id_exists = null;
    SET v_ad_id_max = null;
    SET v_ad_category_id_max = null;
    SET v_phone_id_max = null;
    SET v_ad_phone_id_max = null;
    SET v_category_id_max = null;
    SET v_tag_id_max = null;
    SET v_ad_tag_id_max = null;
    SET v_cursor_not_found = FALSE;
    OPEN cursorAdMax;
    FETCH cursorAdMax INTO v_ad_id_max;
    IF v_cursor_not_found THEN
        SET v_ad_id_max = null;
    END IF;
    CLOSE cursorAdMax;
    SET v_ad_id_max = v_ad_id_max + 1;
    SET v_country_acronym = 'BR';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCountry;
    FETCH cursorCountry INTO v_country_id;
    IF v_cursor_not_found THEN
        SET v_country_id = null;
    END IF;
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
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Raul N Zechin', 'raul-n-zechin', 'Travessao', 'Rua Alberto Rubenich', null, '93950000', -29.62404, -51.09383, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Serviços de Assessoria';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641648', now(), now());
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
        SET v_tag_name = 'REPRESENTACOES REPRESENTANTE COMERCIAL REPRESENTACAO COMERCIAL REPRESENTACAO REPRESENTANTES REPRESENTANTE';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'REPRESENTACOES REPRESENTANTE COMERCIAL REPRESENTACAO COMERCIAL REPRESENTACAO REPRESENTANTES REPRESENTANTE', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Limpa Fossa Dois Irmãos', 'limpa-fossa-dois-irmaos', 'Centro', 'Avenida João Klauck', '0', null, -29.59025, -51.10001, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555198070550', now(), now());
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
        SET v_tag_name = 'Limpa Fossa Dois Irmãos';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Limpa Fossa Dois Irmãos', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Advocacia Pieper, Focesi e Gardyni', 'advocacia-pieper--focesi-e-gardyni', 'Centro', 'Avenida Vinte E Cinco de Julho', '279 05', '93950000', -29.58574, -51.0882, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135646280', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Desentupidora e Limpa Fossa Dois Irmãos-Orçam. Gratis!!!(51)81418085', 'desentupidora-e-limpa-fossa-dois-irmaos-orcam.-gratis!!!(51)81418085', 'Centro', 'Avenida Dez de Setembro', '0', null, -29.58343, -51.08571, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555193989830', now(), now());
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
        SET v_tag_name = 'desentupidora';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'desentupidora', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Desentupidora Limpa Fossa Dois Irmãos(51)81418085-Orçam.Gratis', 'desentupidora-limpa-fossa-dois-irmaos(51)81418085-orcam.gratis', 'Centro', 'Centro da Cidade', '0', null, -29.589, -51.09103, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555184116530', now(), now());
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
        SET v_tag_name = 'desentupidora,limpa fossa';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'desentupidora,limpa fossa', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Desentupidora e Limpa Fossa Dois Irmãos-Orçam. Gratis!!!(51)81418085', 'desentupidora-e-limpa-fossa-dois-irmaos-orcam.-gratis!!!(51)81418085', 'Centro', 'Avenida S. Miguel', '0', null, -29.5829, -51.08677, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555193989830', now(), now());
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
        SET v_tag_name = 'desentupidora';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'desentupidora', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'M B', 'm-b', 'Moinho Velho', 'Rua Adão Hack', '539', '93950000', -29.59072, -51.10155, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135645893', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Desentupidora Dois Irmãos(24)84116530', 'desentupidora-dois-irmaos(24)84116530', 'Centro', 'Centro', '0', null, -29.589, -51.09103, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555184116530', now(), now());
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
        SET v_tag_name = 'Limpa Fossa';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Limpa Fossa', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Otica Sao Miguel', 'otica-sao-miguel', 'Centro', 'Avenida São Miguel', '555', '93950000', -29.58775, -51.0876, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135641130', now(), now());
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
        SET v_tag_name = 'Médicos Fisioterapia Geriatria Dermatologia Acupuntura Psicologia ';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Médicos Fisioterapia Geriatria Dermatologia Acupuntura Psicologia ', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Limpa Fossa Dois Irmão 24h(51)95919298', 'limpa-fossa-dois-irmao-24h(51)95919298', 'Centro', 'Centro', '0', null, -29.589, -51.09103, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555195919298', now(), now());
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
        SET v_tag_name = 'Desentupidora';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Desentupidora', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Centro de Equoterapia Equusterapia', 'centro-de-equoterapia-equusterapia', 'Centro', 'Br116', 'Km 222', null, -29.589, -51.09103, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Terapias Alternativas';
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555192661061', now(), now());
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
        SET v_tag_name = 'equitação, equoterapia';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'equitação, equoterapia', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Emerson Jose da Silv', 'emerson-jose-da-silv', 'Centro', 'Tv Theodomiro Porto da Fonseca 10', '1', '09395000', -29.5848, -51.0882, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643882', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Bolsas Marco', 'bolsas-marco', 'Centro', 'Avenida Florestal', '2419', '93950000', -29.57398, -51.08879, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135643444', now(), now());
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
        SET v_tag_name = 'COURO  ARTEFATO  ATACADO E FABRICACAO CURTUME CURTUMES';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'COURO  ARTEFATO  ATACADO E FABRICACAO CURTUME CURTUMES', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Dois Irmãos Limpa Fossa e Desentupidora (51)84116530', 'dois-irmaos-limpa-fossa-e-desentupidora-(51)84116530', 'Centro', 'Centro', '0', null, -29.589, -51.09103, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555184116530', now(), now());
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
        SET v_tag_name = 'Desentupidora e Limpa Fossa';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'Desentupidora e Limpa Fossa', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Felippe Alfredo Imobiliária', 'felippe-alfredo-imobiliaria', 'Centro', 'Av Dez de Setembro', '831', null, -29.58508, -51.08574, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555189036730', now(), now());
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
        SET v_tag_name = 'imobiliaria imoveis';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'imobiliaria imoveis', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Contra Regra', 'contra-regra', 'Centro', 'Rua Guilherme Engelmann', '121', '93950000', -29.57103, -51.08461, now(), now());
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
        INSERT INTO PHONE_TBL(id, phone, created_at, updated_at) VALUES(v_phone_id_max, '555135644880', now(), now());
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
        SET v_tag_name = 'BORDADOS BORDADO';
        SET v_cursor_not_found = FALSE;
        OPEN cursorTag;
        FETCH cursorTag INTO v_tag_id_exists;
        IF v_cursor_not_found THEN
            SET v_tag_id_exists = null;
        END IF;
        CLOSE cursorTag;
        IF v_tag_id_exists IS NULL THEN
            INSERT INTO TAG_TBL(id, name, created_at, updated_at) VALUES(v_tag_id_max, 'BORDADOS BORDADO', now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Site Eletronicos', 'site-eletronicos', 'Jardim Bonamigo', 'Rua Prca. Isabel', '942', '93950000', -29.62511, -51.0845, now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Tecsistel Sistemas Eletrônicos .', 'tecsistel-sistemas-eletronicos-.', 'Centro', 'Rua Canoas', '26', '93950000', -29.58336, -51.08468, now(), now());
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
    SET v_city_name_uri = 'dois-irmaos';
    SET v_cursor_not_found = FALSE;
    OPEN cursorCity;
    FETCH cursorCity INTO v_city_id;
    IF v_cursor_not_found THEN
        SET v_city_id = null;
    END IF;
    CLOSE cursorCity;
    IF v_city_id IS NOT NULL THEN
        INSERT INTO AD_TBL(id, person_id, city_id, title, title_uri, district, address, address_number, postal_code, map_latitude, map_longitude, created_at, updated_at) VALUES(v_ad_id_max, 1, v_city_id, 'Igreja Universal do Reino de Deus - Dois Irmaos', 'igreja-universal-do-reino-de-deus---dois-irmaos', 'Centro', 'Rua Santo Antônio da Patrulha', '37', null, -29.57996, -51.08929, now(), now());
        SET v_cursor_not_found = FALSE;
        OPEN cursorAdCategoryMax;
        FETCH cursorAdCategoryMax INTO v_ad_category_id_max;
        IF v_cursor_not_found THEN
            SET v_ad_category_id_max = null;
        END IF;
        CLOSE cursorAdCategoryMax;
        SET v_ad_category_id_max = v_ad_category_id_max + 1;
        SET v_category_name = 'Religião';
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
END;
//
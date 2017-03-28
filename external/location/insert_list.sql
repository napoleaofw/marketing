INSERT INTO COUNTRY_TBL(id, name, name_uri, acronym, created_at, updated_at) VALUES(1, 'Brasil', 'brasil', 'BR', now(), now());
INSERT INTO STATE_TBL(id, country_id, name, name_uri, acronym, created_at, updated_at) VALUES(1, 1, 'Rio Grande do Sul', 'rio-grande-do-sul', 'RS', now(), now());
INSERT INTO CITY_TBL(id, state_id, name, name_uri, created_at, updated_at) VALUES(1, 1, 'Dois Irmãos', 'dois-irmaos', now(), now());
INSERT INTO CITY_TBL(id, state_id, name, name_uri, created_at, updated_at) VALUES(2, 1, 'Morro Reuter', 'morro-reuter', now(), now());
INSERT INTO CITY_TBL(id, state_id, name, name_uri, created_at, updated_at) VALUES(3, 1, 'Campo Bom', 'campo-bom', now(), now());
INSERT INTO CITY_TBL(id, state_id, name, name_uri, created_at, updated_at) VALUES(4, 1, 'Ivoti', 'ivoti', now(), now());
INSERT INTO CITY_TBL(id, state_id, name, name_uri, created_at, updated_at) VALUES(5, 1, 'Sapiranga', 'sapiranga', now(), now());
INSERT INTO CITY_TBL(id, state_id, name, name_uri, created_at, updated_at) VALUES(6, 1, 'Novo Hamburgo', 'novo-hamburgo', now(), now());
INSERT INTO CITY_TBL(id, state_id, name, name_uri, created_at, updated_at) VALUES(7, 1, 'Estância Velha', 'estancia-velha', now(), now());
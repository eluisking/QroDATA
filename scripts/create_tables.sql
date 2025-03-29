-- USAMOS LAS BASE DE DATOS DE QRO_Data.
USE qro_datadb;

-- TABLA PLAYERS. **Guardamos los registros de los jugadores.
CREATE TABLE players (
    id_player SERIAL PRIMARY KEY,
    name VARCHAR(35) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    date_birth DATE NOT NULL,
    nationality VARCHAR(20) NOT NULL,
    weight DECIMAL(5,2) NOT NULL,
    height DECIMAL(5,2) NOT NULL,
    position VARCHAR(15) NOT NULL,
    foot VARCHAR(15) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLA TEAMS. **Guardamos los registros de los equipos
CREATE TABLE teams (
    id_team SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    city VARCHAR(35) NOT NULL,
    ligue VARCHAR(30) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLA TOURNAMENTS **Guardamos los registrso de los torneos
CREATE TABLE tournaments (
    id_tournament SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLA MATCHES **Guardamos los registros de los partidos
CREATE TABLE matches (
    id_match SERIAL PRIMARY KEY,
    FK_local_team INTEGER NOT NULL,
    FK_visit_team INTEGER NOT NULL,
    FK_tournament INTEGER NOT NULL,
    local_goals INTEGER NULL,
    visit_goals INTEGER NULL,
    stadium VARCHAR(30),
    date_match DATE NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_matches_local_team FOREIGN KEY (FK_local_team) REFERENCES teams(id_team) ON DELETE CASCADE,
    CONSTRAINT fk_matches_visit_team FOREIGN KEY (FK_visit_team) REFERENCES teams(id_team) ON DELETE CASCADE,
    CONSTRAINT fk_matches_tournament FOREIGN KEY (FK_tournament) REFERENCES tournaments(id_tournament) ON DELETE CASCADE
);

-- TABLA MATCHES_STATS  **Guardamos las estadisticas de los partidos
CREATE TABLE matches_stats (
    id_match_stat SERIAL PRIMARY KEY,
    FK_team_id INTEGER NOT NULL,
    FK_match_id INTEGER NOT NULL,
    possession DECIMAL(5,2) NOT NULL,
    shots INTEGER NOT NULL,
    shots_on_target INTEGER NOT NULL,
    fouls INTEGER NOT NULL,
    yellow_cards INTEGER NOT NULL,
    red_cards INTEGER NOT NULL,
    offsides INTEGER NOT NULL,
    corners INTEGER NOT NULL,
    passes INTEGER NOT NULL,
    pass_accuracy DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_stats_team_id FOREIGN KEY (FK_team_id) REFERENCES teams(id_team) ON DELETE CASCADE,
    CONSTRAINT fk_stats_match_id FOREIGN KEY (FK_match_id) REFERENCES matches(id_match) ON DELETE CASCADE
);

-- TABLA PLAYERS_TOURNAMNETS **Guardamos los registros de los jugadores en los torneos que han participado.
CREATE TABLE players_tournaments (
    id_players_tournament SERIAL PRIMARY KEY,
    FK_player_id INTEGER NOT NULL,
    FK_tournament_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_players_tournaments_player_id FOREIGN KEY (FK_player_id) REFERENCES players(id_player) ON DELETE CASCADE,
    CONSTRAINT fk_players_tournaments_tournament_id FOREIGN KEY (FK_tournament_id) REFERENCES tournaments(id_tournament) ON DELETE CASCADE
);

-- TABLA PLAYERS_GOALS **Guardamos los registros de los goles de los jugadores
CREATE TABLE players_goals (
    id_player_goal SERIAL PRIMARY KEY,
    FK_player_id INTEGER NOT NULL,
    FK_match_id INTEGER NOT NULL,
    minute INTEGER NULL,
    goal_type VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_players_goals_player_id FOREIGN KEY (FK_player_id) REFERENCES players(id_player) ON DELETE CASCADE,
    CONSTRAINT fk_players_goals_match_id FOREIGN KEY (FK_match_id) REFERENCES matches(id_match) ON DELETE CASCADE,
)
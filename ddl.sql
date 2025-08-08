-- DROP SCHEMA public;

-- CREATE SCHEMA public AUTHORIZATION pg_database_owner;
-- public.disciplinas definição

-- Drop table

-- DROP TABLE public.disciplinas;

CREATE TABLE public.disciplinas (
	id serial NOT NULL,
	nome varchar(150) NOT NULL,
	ativo boolean default true,
	CONSTRAINT disciplinas_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX disciplinas_id_idx ON public.disciplinas USING btree (id);


-- public.estudantes definição

-- Drop table

-- DROP TABLE public.estudantes;

CREATE TABLE public.estudantes (
	id serial NOT NULL,
	nome varchar(70) NOT NULL,
	ativo boolean default true,
	CONSTRAINT estudantes_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX estudantes_id_idx ON public.estudantes USING btree (id);


-- public.professores definição

-- Drop table

-- DROP TABLE public.professores;

CREATE TABLE public.professores (
	id serial NOT NULL,
	nome varchar(70) NOT NULL,
	cpf varchar(11) NOT NULL,
	ativo boolean default true,
	CONSTRAINT professores_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX professores_id_idx ON public.professores USING btree (id);


-- public.turmas definição

-- Drop table

-- DROP TABLE public.turmas;

CREATE TABLE public.turmas (
	id serial NOT NULL,
	id_professor int4 NOT NULL,
	id_disciplina int4 NOT NULL,
	ativo boolean default true,
	CONSTRAINT turmas_pk PRIMARY KEY (id),
	CONSTRAINT fk_turmas_disciplina FOREIGN KEY (id_disciplina) REFERENCES public.disciplinas(id),
	CONSTRAINT fk_turmas_professor FOREIGN KEY (id_professor) REFERENCES public.professores(id)
);
CREATE UNIQUE INDEX turmas_id_idx ON public.turmas USING btree (id);


-- public.matriculas definição

-- Drop table

-- DROP TABLE public.matriculas;

CREATE TABLE public.matriculas (
	id serial NOT NULL,
	id_turma int4 NOT NULL,
	id_estudante int4 NOT NULL,
	ativo boolean default true,
	CONSTRAINT matriculas_pk PRIMARY KEY (id),
	CONSTRAINT fk_matriculas_estudante FOREIGN KEY (id_estudante) REFERENCES public.estudantes(id),
	CONSTRAINT fk_matriculas_turma FOREIGN KEY (id_turma) REFERENCES public.turmas(id)
);
CREATE UNIQUE INDEX matriculas_id_idx ON public.matriculas USING btree (id);
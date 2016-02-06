## Preparando o projeto
Este projeto necessita apenas do [Node JS](https://nodejs.org/)  `~0.12.0`.

Utilize os comandos abaio para clonar repositório e baixar todas as dependências do projeto:

```shell
git clone git@gitlab.com:renanoliveira/paraisopolis.git
cd paraisopolis
npm install
bower install
```
Este projeto usa utiliza o [Grunt](http://gruntjs.com) `~0.4.5` para compilar o projeto, execute os comando abaixo para instala-lo:

```shell
npm install -g grunt-cli
```
## Estrutura do projeto

O projeto é modular para facilitar a sua implementação no Wordpress.
Para isso o projeto foi dividido na seguinte estrutura:

```
theme/              
├── html/           Componentes do tema (headers, menus etc) 
├── img/            Imagens
├── js/             Scripts
├── less/           Estilos
└── index.html      Página de referência para os componentes
```

Utilizamos o Grunt para concatenar todas as dependências do front-end, compilar os arquivos em [LESS](http://lesscss.org), mover e renomear as fontes e criar um pré-visualização do tema.
Basta escrever o seguinte comando no terminal:

```shell
grunt build
```
Será gerado então um arquivo `preview.html` dentro da pasta `paraisopolis\theme`.
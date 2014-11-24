# Personalização do Emacs

> Saying that Emacs is just a text editor is like calling iPhone just a
> phone. [(Luke - Terminally Incoherent)](http://www.terminally-incoherent.com/blog/2007/12/13/emacs-with-auctex-as-a-latex-ide/)

---

**Neste diretório git serão mantidos os arquivos de configuração do
Emacs. As instruções abaixo são para Linux e Emacs >=24.3.1.**

---

O [Emacs](http://www.gnu.org/software/emacs/tour/) é o editor de textos
para scripts R e LaTex de minha preferência devido à alta flexibilidade
de personalização. Personalizar é adequar o aplicativo às suas
necessidades de modo a ganhar produtividade. Os bons editores permitem
variar o esquema de cores, tipo de fonte, aplicar destaque de código
(*code highlight*), fazer indentação automática do código e têm
mecanismos de busca e substituição de texto, por exemplo. Além dessas
características fundamentais, no Emacs é possível também criar teclas de
atalho para disparar comandos/funções pré existentes além criar funções
específicas para editar o código. Permite abrir sessões do terminal do
Linux e até mesmo jogar
[tetris](http://www.youtube.com/watch?v=5A8knEALaIY), sem falar no
[psiquiátra](http://www.eeggs.com/items/49593.html) embutido.

Todas as configurações de perzonalização do Emacs são definidas no
arquivo `.emacs`, que no Linux, por padrão, fica na *home* do
usuário. No meu caso, o endereço é `/home/walmes/.emacs`.

Para que se tenha destaque de código R em uma sessão no Emacs é
necessário ter o [ESS](http://ess.r-project.org/) instalado. O ESS nada
mais é que um conjunto de arquivos de configurações adicionais, assim
como `.emacs`, capazes de reconhecer o código R e então aplicar o
destaque de código, fazer indentação, fornecer teclas de atalho para
avaliar o código por linha, região, parágrafo, chunk,
comentar/descomentar blocos de texto, inserir caracteres especiais como
o de atribuição `<-`, ter botões na barra de ferramentas e menus
próprios para sessões R, além de uma infinidade de outras coisas.

Para trabalhar com LaTex, por sua vez, é interessante ter instalado o
[AUCTeX](http://www.gnu.org/software/auctex/). Além do destaque de
código, o AUCTeX traz menus e teclas de atalho e demais funcionalidades
que aumentam consideravelmente a produtividade na edição de textos. Eu
destaco os atalhos para criar os ambientes `\begin{} ... \end{}`,
compilar partes do documento, como uma única equação, indentação do
texto, corretor de ortografia, dobramento de código (*code folding*), e
a facilidade em gerenciar projetos grandes como de livros ou Tese com
código fonte particionado. Para ter o Emacs mais recente, ESS e AUCTeX
basta usar o código abaixo em uma sessão de terminal Linux.

```bash
## Instala o Emacs24 e recursos adicionais.
sudo add-apt-repository ppa:cassou/emacs
sudo apt-get update
sudo apt-get install emacs24 emacs-goodies-el ess auctex

```

Além de editar aquivos do R e LaTex (`*.R`, `*.tex`, `*.Rnw`), o Emacs
também possui recursos voltados à edição de arquivos MarkDown (`*.md`) e
R+MarkDown (`*.Rmd`).

Neste repositório, a maior parte do conteúdo dos aquivos foi encontrada
na internet. Muito do que tenho é comum ao repositório git do
[Fernando~Mayer](https://github.com/fernandomayer/emacs-files) com quem
mantenho contato sobre Emacs, knitr e Git/GitHub. Tentou-se manter a
fonte dos recortes (via url) junto ao código tanto para consulta futura
bem como para dar crédito ao autor. Algumas funções e teclas de atalho
eu desenvolvi e estão sinalizadas e comentadas.

O propósito desse diretório git é manter os arquivos de configuração do
Emacs. Serão mantidos o arquivo `.emacs` com o nome de `dotemacs.el`
(para ter o destaque de código do git) e o diretório `/.emacs.d` com o
nome `/dotemacs.d` (para não ficar oculto). Para usar de ambos faça um
`git clone` (ou copie/baixe) para sua `home` depois renomeie-os.

```bash
## Faz uma cópia do diretório git.
cd ~/Downloads/
git clone git://github.com/walmes/emacs.git
cd emacs
ls

## Tranfere e renomeia.
cp -v dotemacs.el ~/.emacs
cp -vr dotemacs.d/* ~/.emacs.d/

## Alternativamente pode baixar o zip.
cd ~/Downloads/
wget "https://github.com/walmes/emacs/archive/master.zip"
unzip master.zip
cd emacs-master
cp -v dotemacs.el ~/.emacs
cp -vr dotemacs.d/* ~/.emacs.d/
rm -rf ~/Downloads/emacs-master
rm -f ~/Downloads/master.zip

```

As instruções dadas são para Linux. Foram testas no Ubuntu 14.04 e Linux
Mint 17 Quiana. Aos usuários do Windows recomendo usar o Emacs
disponibilizado por
[Vicent~Goulet](http://vgoulet.act.ulaval.ca/en/emacs/) que já vem com o
ESS e AUCTeX. Instruções para usuários de Windows disponíveis no blog do
[John~Cook](http://www.johndcook.com/emacs_windows.html).

Deixe-me saber suas sugestões e reclamações. Faça isso pelo github
clicando em `issues` que fica do lado direito da página. O ícone é uma
bola com o sinal de exclamação dentro (!).

---

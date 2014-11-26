;;=============================================================================
;; Arquivo de configuração do Emacs (>=24.3.1) por Walmes Zeviani.
;;
;; Este arquivo encontra-se disponível em
;; https://github.com/walmes/emacs.
;;
;; A grande maioria do conteúdo aqui disponível foi obtido/inspirado a
;; partir de consultas na internet. Encaminhe dúvidas, problemas e/ou
;; sugestões como um issue no diretório GitHub desse arquivo.
;;=============================================================================

;; http://www.emacswiki.org/wiki/EmacsNiftyTricks
;; “I’ve used emacs for many years now, but have never reached its
;;    maximum potential.” – Anon.

;;-----------------------------------------------------------------------------
;; Definições básicas de sessão.

;; Se emacs-goodies-el não presente, instalar.
;; sudo apt-get install emacs-goodies-el

;; Diretório com arquivos de configuração complementares.
(add-to-list 'load-path "/home/walmes/.emacs.d/")

;; Numeração das linhas na margem esquerda.
;; (global-linum-mode 1)

;; Cor de fundo para a linha do cursor.
(global-hl-line-mode 1)

;; Habilita deletar texto selecionado.
(delete-selection-mode 1)

;; Mostra posição do cursor em relação a margem esquerda.
(setq column-number-mode t)

;; Realçador de pareamento de parenteses, chaves, colchetes, aspas.
(show-paren-mode 1)

;; Quebra de linhas ao exceder largura do texto (padrão é 72
;; caracteres).
(setq-default fill-column 72)

;; Ativa o auto-fill-mode para fazer quebra automática de linhas.
(setq-default auto-fill-function 'do-auto-fill)
 
;; Habilita compartilhamento de área de transferência com outros
;; aplicativos.
(setq x-select-enable-clipboard t)

;; Habilita comentário no início de linhas vazias.
(setq comment-empty-lines t)

;; Desativa o auto salvar e auto backup.
(setq auto-save-default nil) ;; Para o #autosave#.
(setq make-backup-files nil) ;; Para o backup~.

;; Abre o emacs sem a janela de boas vindas.
;; http://blog.droidzone.in/2012/05/22/remove-startup-split-screen-in-emacs/
(setq inhibit-startup-screen t)
(add-hook 'emacs-startup-hook 'delete-other-windows)[/code]

;; Tipo e tamanho da fonte do editor.
(set-default-font "Ubuntu Mono-13")

;; Usa espaços ao ínves de tabs para indentar.
;; http://xenon.stanford.edu/~manku/dotemacs.html
(setq-default indent-tabs-mode nil)

;; Habilita ido-mode.
;; http://www.emacswiki.org/InteractivelyDoThings
(ido-mode t)

;; Para funcionar acentuação no Sony Vaio.
(require 'iso-transl)

;;-----------------------------------------------------------------------------
;; Teclas de atalho de teclado.

;; Define C-TAB para mudar o cursor de janelas (buffers ativos).
(global-set-key [(control tab)] 'other-window)

;; Define C-page down e C-page up para mover entre buffers.
(global-set-key (kbd "C-<next>") 'next-buffer)
(global-set-key (kbd "C-<prior>") 'previous-buffer)

;; Define para C-z a ação 'undo (desfazer), a padrão é padrão C-/.
(global-unset-key "\C-z")
(global-set-key "\C-z" 'undo)

;; Define M-. para marcar parágrafo e (des)comentar.
(global-set-key [?\M-.] (kbd "M-h M-; M-}"))

;; Define M-+ para marcar parágrafo indentar.
(global-set-key [?\M-+] (kbd "M-h C-M-\\"))

;; Define M-= para fazer linha com 77 sinais de =.
(global-set-key [?\M-=] (kbd "C-u 7 7 ="))

;; Define M-- para fazer linha com 77 sinais de -.
(global-set-key [?\M--] (kbd "C-u 7 7 -"))

;; Define C-- para fazer linha com 44 sinais de -.
(global-set-key [?\C--] (kbd "C-u 4 4 -"))

;; Define S-F11 e S-F12 para trocar entre modo com e sem menus.
;; (global-set-key (kbd "<f11>") 'toggle-fullscreen)
(global-set-key (kbd "<S-f11>") 'toggle-menu-bar-mode-from-frame)
(global-set-key (kbd "<S-f12>") 'toggle-tool-bar-mode-from-frame)

;;-----------------------------------------------------------------------------
;; Suporte para MarkDown.
;; (DEVE ESTAR ANTES DO SUPORTE PARA LATEX.)
;; O markdown-mode.el vem com a instalação do emacs-goodies-el.
;;   sudo apt-get install emacs-goodies-el

;; Inicia no modo para markdown para arquivos *.md e *.markdown.
;; http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;-----------------------------------------------------------------------------
;; Suporte para R+MarkDown (requer emacs >= 24.3.1).
;; (DEVE ESTAR ANTES DO SUPORTE PARA LATEX.)

;; Obter polymode da origem (em constante modificação).
;; http://stackoverflow.com/questions/16567348/knitr-markdown-highlighting-in-emacs
;; cd ~/Downloads/
;; git clone https://github.com/vitoshka/polymode.git
;; cd polymode
;; mkdir ~/.emacs.d/polymode/
;; cp -v *.el ~/.emacs.d/polymode/
;; cp -rv ./modes/ ~/.emacs.d/polymode/
;; cd .. && rm -rf polymode

;; Adicionar os diretórios com os modos.
(setq load-path
      (append '("/home/walmes/.emacs.d/polymode/"
                "/home/walmes/.emacs.d/polymode/modes")
              load-path))

;; Chama os modos.
(require 'poly-R)
(require 'poly-markdown)
(require 'poly-noweb)

;;-----------------------------------------------------------------------------
;; Super mega ultra atalhos para sessões R, Rnw e Rmd.
;; http://stackoverflow.com/questions/2901198/useful-keyboard-shortcuts-and-tips-for-ess-r

;; Cuidado! No Linux, os atalhos Ctrol+Alt+F* de 1 à 6 abrem uma sessão
;; modo texto. Com o 7 você volta para o modo gráfico. No Linux
;; interface Unit Alt+F7 permite mover janela com o mouse e Alt+F8
;; permite redimensionar com o mouse.

;; Define atalhos para rodar e mover entre chunks Rnw.
(global-set-key (kbd "C-S-<f5>") 'ess-eval-chunk)                ;; M-n C-M-x
(global-set-key (kbd "C-S-<f6>") 'ess-eval-chunk-and-step)       ;; M-n C-c
(global-set-key (kbd "C-S-<f7>") 'ess-noweb-next-code-chunk)     ;; M-n C-n
(global-set-key (kbd "C-S-<f8>") 'ess-noweb-previous-code-chunk) ;; M-n C-p
(global-set-key (kbd "C-S-<f9>") 'ess-noweb-goto-chunk)          ;; M-n g

;; Define atalhos para rodar e mover entre chunks Rmd.
(global-set-key (kbd "S-<f7>") 'polymode-previous-chunk-same-type)
(global-set-key (kbd "S-<f8>") 'polymode-next-chunk-same-type)

;;-----------------------------------------------------------------------------
;; Esquema de cores solarized-dark.

;; Correr no terminal do Linux.
;; git clone https://github.com/sellout/emacs-color-theme-solarized ~/Downloads/sol/
;; mkdir ~/.emacs.d/emacs-color-theme-solarized/
;; cp -v ~/Downloads/sol/*.el ~/.emacs.d/emacs-color-theme-solarized/
;; rm -rf ~/Downloads/sol/ 

(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)

(add-to-list 'load-path "/home/walmes/.emacs.d/emacs-color-theme-solarized")
(require 'color-theme-solarized)
(color-theme-solarized-dark)

;;-----------------------------------------------------------------------------
;; Para avaliar linhas/regiões no terminal aberto do Linux no Emacs tal
;; como é feio para código R.
;; cd /home/walmes/.emacs.d/
;; wget 'http://www.emacswiki.org/emacs/download/essh.el'

;; Carrega suplemento.
(require 'essh)

;; Define atalho para avaliar linha (sem selecionar) e região.
(global-set-key [?\C-*] 'pipe-line-to-shell-and-step)
(global-set-key [?\C-&] 'pipe-region-to-shell)

;;-----------------------------------------------------------------------------
;; isand-mode.
;; https://github.com/ffevotte/isend-mode.el/blob/master/isend-mode.el

;; Download e instalação. Executar no terminal linux.
;; cd ~/Downloads/
;; git clone https://github.com/ffevotte/isend-mode.el.git
;; cd isend-mode.el
;; mv -v isend*.el ~/.emacs.d/ 
;; rm -rf ~/Downloads/isend*

(require 'isend)

(defun isend-help ()
  "Insert a help at the cursor."
  (interactive)
  (message "M-x ansi-term RET /bin/sh RET; M-x isend-associate RET *ansi-term* RET"))

;;-----------------------------------------------------------------------------
;; Auto complete mode para o emacs.
;; http://cx4a.org/software/auto-complete/
;; http://www.emacswiki.org/emacs/ESSAuto-complete

;; cd ~/Downloads/
;; wget http://cx4a.org/pub/auto-complete/auto-complete-1.3.1.zip
;; unzip auto-complete*.zip
;; cd auto-complete*
;; cp -v *.el ~/.emacs.d/
;; cp -rv ./dict ~/.emacs.d/
;; rm -rf ~/Downloads/auto-complete*

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/walmes/.emacs.d/ac-dict")
(ac-config-default)

(setq ess-use-auto-complete 'script-only)

;; Define M-h para acesso rápido à opções de completar.
(define-key ac-completing-map (kbd "M-h") 'ac-quick-help)
(define-key ac-completing-map "\M-n" nil) ;; was ac-next
(define-key ac-completing-map "\M-p" nil) ;; was ac-previous
(define-key ac-completing-map "\M-," 'ac-next)
(define-key ac-completing-map "\M-k" 'ac-previous)

;; Retira 'ac-complete do ENTER e passa para o TAB.
(define-key ac-completing-map "\r" nil)
(define-key ac-completing-map "\t" 'ac-complete)

;;-----------------------------------------------------------------------------
;; Adicionar o reposítório MELPA à lista de repositórios de pacotes para
;; o Emacs. O Bookmark+ está lá.

(when (> emacs-major-version 23)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives 
               '("melpa" . "http://melpa.milkbox.net/packages/")
               'APPEND))

;; Then use ‘M-x list-packages’ and click `bookmark+’ in the list of
;; available pacakges. Pressionar `i` para marcar para instalação e
;; pressionar `x` para executar.
;; Também pode-se fazer clone do git em:
;; https://github.com/emacsmirror/bookmark-plus.git

;; cd ~/Downloads/
;; git clone https://github.com/emacsmirror/bookmark-plus.git ~/Downloads/bkmp
;; rm -rf ~/Downloads/bkmp/.git
;; mkdir ~/.emacs.d/elpa/
;; cp -vr ~/Downloads/bkmp ~/.emacs.d/elpa/bookmark+/
;; rm -rf ~/Downloads/bkmp

;; É necessário renomear o diretório porque vem com um número de sufixo
;; que marca a versão se for instalado pelo melpa.

;; (add-to-list 'load-path "/home/walmes/.emacs.d/elpa/bookmark+/")
;; (require 'bookmark+)

;; Bookmarks temporários.
;; (bmkp-toggle-autotemp-on-set)

;;-----------------------------------------------------------------------------
;; Visible bookmarks. Easy movement.
;; https://marmalade-repo.org/packages/bm

;; Correr em uma sessão de terminal Linux.
;; cd ~/Downloads/
;; wget https://marmalade-repo.org/packages/bm-1.53.el
;; mv -v  bm*.el ~/.emacs.d/bm.el

(require 'bm)

;; http://emacsworld.blogspot.com.br/2008/09/visual-bookmarks-package-for-emacs.html
;; Customise the colours by using M-x customize-group RET bm RET
(setq bm-marker 'bm-marker-left)
(setq bm-highlight-style 'bm-highlight-only-fringe)
;; (setq bm-highlight-style 'bm-highlight-only-line)
;; (setq bm-highlight-style 'bm-highlight-line-and-fringe)

(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>") 'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

;;-----------------------------------------------------------------------------
;; Suporte Latex
;; http://www.terminally-incoherent.com/blog/2007/12/13/emacs-with-auctex-as-a-latex-ide/
;;   sudo apt-get install auctex

;; Modo matemático para LaTex (Math no menu com atalhos para símbolos,
;; etc).
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; Para instalar dicionário português.
;;   sudo apt-get install aspell-pt aspell-pt-br aspell-pt-pt  
;; Para mudar o idioma da correção (portuguese, english, etc).
;;   M-x ispell-change-dictionary RET english RET
;; Para ver os dicionários disponíveis.
;;   M-x ispell-aspell-dictionary-alist

;; Correção de ortografia on the fly (durante digitação palavras não
;; contidas no dicionário ficam em destaque). Em sessões R, destaca
;; nomes das funções. Deixa a edição lenta.
;; http://piotrkazmierczak.com/2010/05/13/emacs-as-the-ultimate-latex-editor/

;; (setq ispell-program-name "aspell")   ;; pode ser "ispell" também
;; (setq ispell-dictionary "english")    ;; ou português
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'latex-mode-hook 'flyspell-mode)
;; (add-hook 'tex-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-buffer)
;; (add-hook 'bibtex-mode-hook 'flyspell-mode)

;; Suporte do refTex para navegar por grandes documentos (Ref no menu,
;; navegação, sumário).
;; http://piotrkazmierczak.com/2010/05/13/emacs-as-the-ultimate-latex-editor/

(require 'tex-site)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;;-----------------------------------------------------------------------------
;; Abre o terminal do Linux partindo a janela. O Emacs 24 se comporta
;; diferente do 23 para esse comando. Para o Emacs 23, troque de lugar
;; as linhas identificadas com 1 e 2 deixando 2 e 1.

(defun open-shell-split-window ()
  "Abre o terminal com partição da janela."
  (interactive)
  (split-window)
  (shell)
  (previous-buffer) ;; 1
  (other-window 1)
  (next-buffer)     ;; 2
  (other-window 1)
  )

;; Define atalho.
(global-set-key (kbd "M-T") 'open-shell-split-window)

;;-----------------------------------------------------------------------------
;; O mesmo para eshell.

(defun open-eshell-split-window ()
  "Abre o terminal com partição da janela."
  (interactive)
  (split-window)
  (eshell)
  (previous-buffer) ;; 1
  (other-window 1)
  (next-buffer)     ;; 2
  (other-window 1)
  )

;; Define atalho.
(global-set-key (kbd "M-E") 'open-eshell-split-window)

;; http://www.emacswiki.org/emacs/EshellControlFromOtherBuffer
(defun my-eshell-execute-current-line ()
  "Insert text of current line in eshell and execute."
  (interactive)
  (require 'eshell)
  (let ((command (buffer-substring
                  (save-excursion
                    (beginning-of-line)
                    (point))
                  (save-excursion
                    (end-of-line)
                    (point)))))
    (let ((buf (current-buffer)))
      (unless (get-buffer eshell-buffer-name)
        (eshell))
      (display-buffer eshell-buffer-name t)
      (switch-to-buffer-other-window eshell-buffer-name)
      (end-of-buffer)
      (eshell-kill-input)
      (insert command)
      (eshell-send-input)
      (end-of-buffer)
      (switch-to-buffer-other-window buf))))

(global-set-key [f8] 'my-eshell-execute-current-line)

;;-----------------------------------------------------------------------------
;; Funções inserir o dia e a hora no buffer.

;; http://stackoverflow.com/questions/251908/how-can-i-insert-current-date-and-time-into-a-file-using-emacs
(defun today ()
  "Insert string for today's date nicely formatted in American style,
   e.g. Sunday, September 17, 2000."
  (interactive)                 ; permit invocation in minibuffer
  ;; (insert (format-time-string "%A, %e de %B , %Y"))
  (insert (format-time-string "%e/%m/%Y"))
)
  
(defun header ()
  "Insere cabeçalho."
  (interactive)
  ;; (insert (comment-dwim 2) (make-string 77 ?=) "\n")
  (insert (make-string 77 ?=) "\n")
  (insert (make-string 63 ? ) "Walmes Zeviani\n")
  (insert (make-string 63 ? ) "walmes@ufpr.br\n")
  (insert (make-string 67 ? ) (format-time-string "%d-%m-%Y\n"))
  (insert (make-string 77 ?=) "\n")
  )

;;-----------------------------------------------------------------------------
;; Função para duplicar linhas (esse comando/atalho é muito útil).
;; http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs

;; Define função para duplicar linhas.
(defun duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank)
  )

;; Define atalho para duplicar linhas.
(global-set-key (kbd "\C-c d") 'duplicate-line)

;;-----------------------------------------------------------------------------
;; Para copiar e recortar linhas sem selecionar. Ao selecionar, vale a
;; região selecionada.
;; http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html

(defun copy-line-or-region ()
  "Copy current line, or current text selection."
  (interactive)
  (if (region-active-p)
      (kill-ring-save
       (region-beginning)
       (region-end)
       )
    (kill-ring-save
     (line-beginning-position)
     (line-beginning-position 2)
     )
    )
  )

(defun cut-line-or-region ()
  "Cut the current line, or current text selection."
  (interactive)
  (if (region-active-p)
      (kill-region
       (region-beginning)
       (region-end)
       )
    (kill-region
     (line-beginning-position)
     (line-beginning-position 2)
     )
    )
  )

;; Redefine os atalhos.
(global-set-key (kbd "S-<delete>") 'cut-line-or-region)  ; cut.
(global-set-key (kbd "C-<insert>") 'copy-line-or-region) ; copy.

;;-----------------------------------------------------------------------------
;; Para comentar linhas sem selecionar. Se selecionar irá comentar a
;; região.

(defun comment-line-or-region ()
  "Comment or uncomment current line, or current text selection."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region
       (region-beginning)
       (region-end)
       )
    (comment-or-uncomment-region
     (line-beginning-position)
     (line-beginning-position 2)
     )
    )
  )

;; Define atalho para comentar linhas ou regiões.
(global-set-key (kbd "M-;") 'comment-line-or-region)

;;-----------------------------------------------------------------------------
;; Para mover linhas (esse comando/atalho é muito útil).
;; http://www.emacswiki.org/emacs/MoveLine

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

;; Define atalhos.
(global-set-key (kbd "M-<") 'move-line-up)
(global-set-key (kbd "M->") 'move-line-down)

;;-----------------------------------------------------------------------------
;; Para mover regiões de texto selecionadas (esse comando é muito útil).

(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))

;; Define atalhos.
(global-set-key (kbd "M-[") 'move-region-up)
(global-set-key (kbd "M-]") 'move-region-down)

;;-----------------------------------------------------------------------------
;; Aprimoramento da função occur. Permite rápida navegação.
;; http://ignaciopp.wordpress.com/2009/06/10/customizing-emacs-occur/

(defun my-occur (&optional arg)
  "Make sure to always put occur in a vertical split, into a
   narrower buffer at the side. I didn't like the default
   horizontal split, nor the way it messes up the arrangement of
   windows in the frame or the way in which the standard way uses
   a neighbor window."
  (interactive "P")
  ;; store whatever frame configuratin we are currently in
  (window-configuration-to-register ?y)
  (occur (read-from-minibuffer "Regexp: "))
  (if (occur-check-existence)
      (progn
        (delete-other-windows)
	;; (split-window-horizontally)
	;; (enlarge-window-horizontally -30)
        (split-window-vertically)
        (enlarge-window -10)
	;; (set-cursor-color "green")
        )
    )
  (occur-procede-accordingly)
  (next-error-follow-minor-mode) ;;+
  )

(defun occur-procede-accordingly ()
  "Switch to occur buffer or prevent opening of the occur window
   if no matches occured."
  (interactive "P")
  (if (not(get-buffer "*Occur*"))
      (message "There are no results.")
    (switch-to-buffer "*Occur*")))

(defun occur-check-existence()
  "Signal the existance of an occur buffer depending on the
   number of matches."
  (interactive)
  (if (not(get-buffer "*Occur*")) nil t)
  )

;; Define atalho.
(define-key global-map (kbd "C-S-o") 'my-occur)

;; http://www.emacswiki.org/emacs/OccurMode
;; para mostrar mais linhas ao redor da que casa (mais contexto) use
;; C-U 5 M-x occur regexp-to-search

(defun occur-mode-quit ()
  "Quit and close occur window. I want to press 'q' and leave
   things as they were before in regard of the split of windows
   in the frame. This is the equivalent of pressing C-x 0 and
   reset windows in the frame, in whatever way they were, plus
   jumping to the latest position of the cursor which might have
   been changed by using the links out of any of the matches
   found in occur."
  (interactive)
  (switch-to-buffer "*Occur*")
  ;; in order to know where we put the cursor thay might have jumped from qoccur
  (other-window 1)                  ;; go to the main window
  (point-to-register ?1)            ;; store the latest cursor position
  (switch-to-buffer "*Occur*")      ;; go back to the occur window
  (kill-buffer "*Occur*")           ;; delete it
  (jump-to-register ?y)             ;; reset the original frame state
  ;; (set-cursor-color "rgb:ff/fb/53") ;; reset cursor color
  (register-to-point ?1))           ;; re-position cursor

;; Some key bindings defined below. Use "p" ans "n" as in dired mode
;; (without Cntrl key) for previous and next line; just show occurrence
;; without leaving the "occur" buffer; use RET to display the line of
;; the given occurrence, instead of jumping to i,t which you do clicking
;; instead; also quit mode with Ctrl-g.

(define-key occur-mode-map (kbd "q") 'occur-mode-quit)
;; (define-key occur-mode-map (kbd "C-RET") 'occur-mode-goto-occurrence-other-window)
;; (define-key occur-mode-map (kbd "C-<up>") 'occur-mode-goto-occurrence-other-window)
;; (define-key occur-mode-map (kbd "RET") 'occur-mode-display-occurrence)
;; (define-key occur-mode-map (kbd "p") 'previous-line)
;; (define-key occur-mode-map (kbd "n") 'next-line)

;;-----------------------------------------------------------------------------
;; Função para remover espaços em branco extra em região de texto.
;; Selecione o texto e aplique. Útil em arquivos *.tex.
;; http://stackoverflow.com/questions/8674912/how-to-collapse-whitespaces-in-a-region

(defun just-one-space-in-region (beg end)
  "Replace all whitespace in the region with single spaces."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward "\\s-+" nil t)
        (replace-match " "))
      )
    )
  )

;;-----------------------------------------------------------------------------
;; Todo paragráfo/região em uma linha.
;; http://www.emacswiki.org/emacs/UnfillParagraph

(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line
   of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;; http://ergoemacs.org/emacs/emacs_unfill-paragraph.html
(defun unfill-region (start end)
  "Replace newline chars in region by single spaces.
   This command does the inverse of `fill-region'."
  (interactive "r")
  (let ((fill-column 90002000))
    (fill-region start end)))

;; Define atalho. Lembre-se que M-q é para fill-region.
(define-key global-map "\M-Q" 'unfill-region)

;;-----------------------------------------------------------------------------
;; Comentário em texto LaTex sempre em linha exclusiva, nunca atrás de
;; texto.

;; Selecionar a região para aplicar.
(defun latex-comments-at-start-line (beg end)
  "Cometário do LaTex (%) sempre no início das linhas."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char 1)
      ;; Todo `%` no começo de linha recebe `\` antes ficando `\%`.
      (while (re-search-forward "\n%" nil t)
	(replace-match "\n\\%" nil t))
      (goto-char 1)
      ;; Todo `%` não precedido de `\` passa para uma nova linha.
      (while (re-search-forward "[^\\]%" nil t)
	(replace-match "\n\\%" nil t))
      (goto-char 1)
      ;; Todo `\%` no começo de uma linha vira `%`.
      (while (re-search-forward "\n[\\]%" nil t)
	(replace-match "\n% " nil t))
      (goto-char 1)
      ;; Qualquer quantidade de `%` no inicio da linha converte para `%% `.
      (while (re-search-forward "\n%+\\s-*" nil t)
	(replace-match "\n%% " nil t))
      )
    )
  )

;;-----------------------------------------------------------------------------
;; Comentário em script R sempre em linha exclusiva, nunca atrás de
;; comandos. Usou-se o `M-x re-builder` para construir as REGEX.

;; Selecionar a região para aplicar.
(defun r-comments-before-commands (beg end)
  "Cometário do R (#) sempre no início das linhas."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char 1)
      ;; Todo `#` que não esteja no começo de linha ou apenas precedido de
      ;; espaço vai linha antes do comando.
      (while (re-search-forward "\\(\n.*\\w\\).*[^\"\']#+\\(.*\\)" nil t)
	(replace-match "\n## \\2\\1" t nil))
      )
    )
  )

;; Define atalho.
(global-set-key (kbd "M-_") 'r-comments-before-commands)

;;-----------------------------------------------------------------------------
;; Tranforma toda quantidade não separada de `#` em `##`. Útil para
;; padronizar o estilo de comentário do código.

;; Selecionar a região para aplicar.
(defun r-double-hash-only (beg end)
  "Cometário do R (#) sempre no início das linhas."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char 1)
      ;; Qualquer quantidade de # colada na borda é substituida por `## `.
      (while (re-search-forward "^#+" nil t)
	(replace-match "## " t nil))
      )
    )
  )

;; Define atalho.
(global-set-key (kbd "M-#") 'r-double-hash-only)

;;-----------------------------------------------------------------------------
;; Para adicionar conteúdo ao final das linhas. Útil para colocar `;` ao
;; final de linhas dentro do corpo de funções em R. Isso garante que
;; mesmo ocorrendo quebras de linhas desastrosas, o código tem alguma
;; garantia de funcionar.
;; http://stackoverflow.com/questions/4870704/appending-characters-to-the-end-of-each-line-in-emacs

;; Colocar `;` no final das linhas em uma região.
;; M-x replace-regexp RET $ RET ; RET

;; (defun add-string-to-end-of-lines-in-region (str b e)
;;   "Prompt for string, add it to end of lines in the region."
;;   (interactive "What shall we append? \nr")
;;   (goto-char e)
;;   (forward-line -1)
;;   (while (> (point) b)
;;     (end-of-line)
;;     (insert str)
;;     (forward-line -1)))
;; 
;; ;; Define o atalho.
;; (global-set-key (kbd "C-M-;") 'add-string-to-end-of-lines-in-region)

;;-----------------------------------------------------------------------------
;; Alterações feitas com M-x customize-group RET bookmark-plus
;; Alterações feitas com M-x customize-group RET bm

;; Se dois buffers tem o mesmo nome (file1.txt) ele concatena com o 
;; diretório para diferenciar, dir1|file.txt e dir2|file.txt. 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(initial-frame-alist (quote ((fullscreen . maximized))))
 ;; '(bmkp-auto-light-when-jump (quote any-bookmark))
 ;; '(bmkp-auto-light-when-set (quote any-bookmark))
 ;; '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 ;; '(bmkp-light-left-fringe-bitmap (quote left-triangle))
 ;; '(bmkp-light-right-fringe-bitmap (quote right-triangle))
 ;; '(bmkp-light-style-autonamed (quote lfringe))
 ;; '(bmkp-light-style-non-autonamed (quote lfringe))
 ;; '(bmkp-temporary-bookmarking-mode nil)
 ;; Para não marcar como selecionada regiões entre mark e point.
 ;; C-<space> para marcar, C-x C-x para saltar entre point e mark.
 '(transient-mark-mode nil)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bm-face ((t (:background "DarkOrange1" :foreground "Black")))))

;;-----------------------------------------------------------------------------

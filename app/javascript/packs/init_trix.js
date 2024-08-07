import Trix from 'trix';

window.Trix = Trix;
const { lang } = Trix.config;

const initTrix = () => {
  Trix.config.toolbar.getDefaultHTML = getDefaultHTML.bind(this);
  addTextAlignCenterButtonConfig();
  addTextAlignRightButtonConfig();
  addTextAlignJustifyButtonConfig();
  addTextAlignLeftButtonConfig();
  addImageSmallButtonConfig();
  addImageMediumButtonConfig();
  addImageLargeButtonConfig();
};

const addTextAlignCenterButtonConfig = () => {
  Trix.config.blockAttributes.textAlignCenter = {
    tagName: 'centered-div'
  };
};

const addTextAlignRightButtonConfig = () => {
  Trix.config.blockAttributes.textAlignRight = {
    tagName: 'right-div'
  };
};

const addTextAlignJustifyButtonConfig = () => {
  Trix.config.blockAttributes.textAlignJustify = {
    tagName: 'justified-div'
  };
};

const addTextAlignLeftButtonConfig = () => {
  Trix.config.blockAttributes.textAlignLeft = {
    tagName: 'left-div'
  };
};

const addImageSmallButtonConfig = () => {
  Trix.config.blockAttributes.imageSmall = {
    tagName: 'image-small'
  };
};
const addImageMediumButtonConfig = () => {
  Trix.config.blockAttributes.imageMedium = {
    tagName: 'image-medium'
  };
};
const addImageLargeButtonConfig = () => {
  Trix.config.blockAttributes.imageLarge = {
    tagName: 'image-large'
  };
};

const getDefaultHTML = () => {
  return `<div class="trix-button-row">
    <span class="trix-button-group trix-button-group--text-tools" data-trix-button-group="text-tools">
      <button type="button" class="trix-button trix-button--icon trix-button--icon-bold" data-trix-attribute="bold" data-trix-key="b" title="${lang.bold}" tabindex="-1">${lang.bold}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-italic" data-trix-attribute="italic" data-trix-key="i" title="${lang.italic}" tabindex="-1">${lang.italic}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-strike" data-trix-attribute="strike" title="${lang.strike}" tabindex="-1">${lang.strike}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-link" data-trix-attribute="href" data-trix-action="link" data-trix-key="k" title="${lang.link}" tabindex="-1">${lang.link}</button>
    </span>
    <span class="trix-button-group trix-button-group--block-tools" data-trix-button-group="block-tools">
      <button type="button" class="trix-button trix-button--icon trix-button--icon-heading-1" data-trix-attribute="heading1" title="${lang.heading1}" tabindex="-1">${lang.heading1}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-quote" data-trix-attribute="quote" title="${lang.quote}" tabindex="-1">${lang.quote}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-code" data-trix-attribute="code" title="${lang.code}" tabindex="-1">${lang.code}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-bullet-list" data-trix-attribute="bullet" title="${lang.bullets}" tabindex="-1">${lang.bullets}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-number-list" data-trix-attribute="number" title="${lang.numbers}" tabindex="-1">${lang.numbers}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-decrease-nesting-level" data-trix-action="decreaseNestingLevel" title="${lang.outdent}" tabindex="-1">${lang.outdent}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-increase-nesting-level" data-trix-action="increaseNestingLevel" title="${lang.indent}" tabindex="-1">${lang.indent}</button>
    </span>
    ${textAlignButtons()}
    <span class="trix-button-group trix-button-group--file-tools" data-trix-button-group="file-tools">
      <button type="button" class="trix-button trix-button--icon trix-button--icon-attach" data-trix-action="attachFiles" title="${lang.attachFiles}" tabindex="-1">${lang.attachFiles}</button>
    </span>
    ${imageResizeButtons()}
    <span class="trix-button-group-spacer"></span>
    <span class="trix-button-group trix-button-group--history-tools" data-trix-button-group="history-tools">
      <button type="button" class="trix-button trix-button--icon trix-button--icon-undo" data-trix-action="undo" data-trix-key="z" title="${lang.undo}" tabindex="-1">${lang.undo}</button>
      <button type="button" class="trix-button trix-button--icon trix-button--icon-redo" data-trix-action="redo" data-trix-key="shift+z" title="${lang.redo}" tabindex="-1">${lang.redo}</button>
    </span>
  </div>
  <div class="trix-dialogs" data-trix-dialogs>
    <div class="trix-dialog trix-dialog--link" data-trix-dialog="href" data-trix-dialog-attribute="href">
      <div class="trix-dialog__link-fields">
        <input type="url" name="href" class="trix-input trix-input--dialog" placeholder="${lang.urlPlaceholder}" aria-label="${lang.url}" required data-trix-input>
        <div class="trix-button-group">
          <input type="button" class="trix-button trix-button--dialog" value="${lang.link}" data-trix-method="setAttribute">
          <input type="button" class="trix-button trix-button--dialog" value="${lang.unlink}" data-trix-method="removeAttribute">
        </div>
      </div>
    </div>
  </div>`;
};

const textAlignButtons = () => {
  return `<span class="trix-button-group trix-button-group--align-tools" data-trix-button-group="align-tools">
            <button type="button" class="trix-button" data-trix-attribute="textAlignLeft" title="à esquerda">
              <span class="icon"><i class="fas fa-align-left fa-lg"></i></span>
            </button>
            <button type="button" class="trix-button" data-trix-attribute="textAlignCenter" title="ao centro">
              <span class="icon"><i class="fas fa-align-center fa-lg"></i></span>
            </button>
            <button type="button" class="trix-button" data-trix-attribute="textAlignRight" title="à direita">
              <span class="icon"><i class="fas fa-align-right fa-lg"></i></span>
            </button>
            <button type="button" class="trix-button" data-trix-attribute="textAlignJustify" title="justificado">
              <span class="icon"><i class="fas fa-align-justify fa-lg"></i></span>
            </button>
          </span>`;
};

const imageResizeButtons = () => {
  return `<span class="trix-button-group trix-button-group--image-tools" data-trix-button-group="image-tools">
            <button type="button" class="trix-button" data-trix-attribute="imageSmall" title="Imagem pequena">
              <span class="icon"><i class="fa-solid fa-p fa-lg"></i></span>
            </button>
            <button type="button" class="trix-button" data-trix-attribute="imageMedium" title="Imagem média">
              <span class="icon"><i class="fa-solid fa-m fa-lg"></i></span>
            </button>
            <button type="button" class="trix-button" data-trix-attribute="imageLarge" title="Imagem grande">
              <span class="icon"><i class="fa-solid fa-g fa-lg"></i></span>
            </button>
          </span>`;
};

document.addEventListener('trix-before-initialize', () => {
  initTrix();
});

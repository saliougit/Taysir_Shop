<?php
/**
* @author      Krzysztof Pecak
* @copyright   2024 Krzysztof Pecak
* @license     http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class AngarWhatsapp extends Module
{
    public function __construct()
    {
        $this->name = 'angarwhatsapp';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'angarthemes';
        $this->need_instance = 0;

        $this->bootstrap = true;
        parent::__construct();

        $this->displayName = $this->l('AT - Whatsapp');
        $this->description = $this->l('This module displays whatsapp chat button');
        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);

        $this->templateFile = 'module:angarwhatsapp/views/templates/hook/angarwhatsapp.tpl';
    }

    public function install()
    {
        return
            parent::install() &&
            $this->registerHook('displayHeader') &&
            $this->registerHook('displayFooter') &&
            $this->registerHook('displayProductAdditionalInfo') &&
            $this->installFixtures();
    }

	protected function installFixtures()
	{
		$languages = Language::getLanguages(false);
		$values = array();

		foreach ($languages as $lang) {

			$id_lang = (int)$lang['id_lang'];

			if ($id_lang == Language::getIdByIso('fr')) {
				$values['ANGARWHATSAPP_DEFAULT_MESSAGE'][$id_lang] = 'Bonjour, j\'ai quelques questions.';
			} elseif ($id_lang == Language::getIdByIso('es')) {
				$values['ANGARWHATSAPP_DEFAULT_MESSAGE'][$id_lang] = 'Hola, tengo algunas preguntas.';
			} elseif ($id_lang == Language::getIdByIso('pl')) {
				$values['ANGARWHATSAPP_DEFAULT_MESSAGE'][$id_lang] = 'Witam, mam kilka pytań.';
			} elseif ($id_lang == Language::getIdByIso('it')) {
				$values['ANGARWHATSAPP_DEFAULT_MESSAGE'][$id_lang] = 'Ciao, ho alcune domande.';
			} elseif ($id_lang == Language::getIdByIso('nl')) {
				$values['ANGARWHATSAPP_DEFAULT_MESSAGE'][$id_lang] = 'Hallo, ik heb een paar vragen.';
			} elseif ($id_lang == Language::getIdByIso('de')) {
				$values['ANGARWHATSAPP_DEFAULT_MESSAGE'][$id_lang] = 'Hallo, ich habe ein paar Fragen.';
			} elseif ($id_lang == Language::getIdByIso('cs')) {
				$values['ANGARWHATSAPP_DEFAULT_MESSAGE'][$id_lang] = 'Dobrý den, mám pár otázek.';
			} else {
				$values['ANGARWHATSAPP_DEFAULT_MESSAGE'][$id_lang] = 'Hello, I have a few questions.';
			}

			if ($id_lang == Language::getIdByIso('fr')) {
				$values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$id_lang] = 'Bonjour, j\'ai une question à propos de ce produit:';
			} elseif ($id_lang == Language::getIdByIso('es')) {
				$values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$id_lang] = 'Hola, tengo una pregunta sobre este producto:';
			} elseif ($id_lang == Language::getIdByIso('pl')) {
				$values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$id_lang] = 'Witam, mam pytanie dotyczące tego produktu:';
			} elseif ($id_lang == Language::getIdByIso('it')) {
				$values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$id_lang] = 'Ciao, ho una domanda su questo prodotto:';
			} elseif ($id_lang == Language::getIdByIso('nl')) {
				$values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$id_lang] = 'Hallo, ik heb een vraag over dit product:';
			} elseif ($id_lang == Language::getIdByIso('de')) {
				$values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$id_lang] = 'Hallo, ich habe eine Frage zu diesem Produkt:';
			} elseif ($id_lang == Language::getIdByIso('cs')) {
				$values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$id_lang] = 'Dobrý den, mám dotaz k tomuto produktu:';
			} else {
				$values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$id_lang] = 'Hello, I have a question about this product:';
			}

		}

		Configuration::updateValue('ANGARWHATSAPP_DEFAULT_MESSAGE', $values['ANGARWHATSAPP_DEFAULT_MESSAGE'], true);
		Configuration::updateValue('ANGARWHATSAPP_PRODUCTPAGE_MESSAGE', $values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE']);

		Configuration::updateValue('ANGARWHATSAPP_PHONE', Configuration::get('PS_SHOP_PHONE'));
		Configuration::updateValue('ANGARWHATSAPP_PRODUCTLINK', '1');
		Configuration::updateValue('ANGARWHATSAPP_STYLE', 'pulse');
		Configuration::updateValue('ANGARWHATSAPP_POSITION', 'bottom_right');
		Configuration::updateValue('ANGARWHATSAPP_SIZE', '50px');

		return true;
	}

    public function uninstall()
    {
        Configuration::deleteByName('ANGARWHATSAPP_DEFAULT_MESSAGE');
        Configuration::deleteByName('ANGARWHATSAPP_PRODUCTPAGE_MESSAGE');

        Configuration::deleteByName('ANGARWHATSAPP_PHONE');
        Configuration::deleteByName('ANGARWHATSAPP_PRODUCTLINK');
        Configuration::deleteByName('ANGARWHATSAPP_STYLE');
        Configuration::deleteByName('ANGARWHATSAPP_POSITION');
        Configuration::deleteByName('ANGARWHATSAPP_SIZE');

        return parent::uninstall();
    }

    public function hookDisplayHeader($params)
    {
        $this->context->controller->addCSS($this->_path.'views/css/angarwhatsapp.css', 'all');
    }

    public function hookDisplayFooter($params)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId('angarwhatsapp'))) {
            $this->smarty->assign(array(
                'angarwhatsapp_default_message' => Configuration::get('ANGARWHATSAPP_DEFAULT_MESSAGE', $this->context->language->id),
                'angarwhatsapp_phone' => Configuration::get('ANGARWHATSAPP_PHONE'),
                'angarwhatsapp_style' => Configuration::get('ANGARWHATSAPP_STYLE'),
                'angarwhatsapp_position' => Configuration::get('ANGARWHATSAPP_POSITION'),
                'angarwhatsapp_size' => Configuration::get('ANGARWHATSAPP_SIZE')
            ));
        }

        return $this->display(__FILE__, 'views/templates/front/angarwhatsapp.tpl', $this->getCacheId('angarwhatsapp'));
    }

    public function hookDisplayProductAdditionalInfo($params)
    {
		$this->smarty->assign(array(
			'angarwhatsapp_productpage_message' => Configuration::get('ANGARWHATSAPP_PRODUCTPAGE_MESSAGE', $this->context->language->id),
			'angarwhatsapp_phone' => Configuration::get('ANGARWHATSAPP_PHONE'),
			'angarwhatsapp_productlink' => Configuration::get('ANGARWHATSAPP_PRODUCTLINK')
		));

        return $this->display(__FILE__, 'views/templates/front/angarwhatsapp_button.tpl');
    }

    public function postProcess()
    {
        if (Tools::isSubmit('submitStoreConf')) {
            $languages = Language::getLanguages(false);
            $values = array();

            foreach ($languages as $lang) {
                $values['ANGARWHATSAPP_DEFAULT_MESSAGE'][$lang['id_lang']] = Tools::getValue('ANGARWHATSAPP_DEFAULT_MESSAGE_'.$lang['id_lang']);
                $values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$lang['id_lang']] = Tools::getValue('ANGARWHATSAPP_PRODUCTPAGE_MESSAGE_'.$lang['id_lang']);
            }
 
            Configuration::updateValue('ANGARWHATSAPP_DEFAULT_MESSAGE', $values['ANGARWHATSAPP_DEFAULT_MESSAGE']);
            Configuration::updateValue('ANGARWHATSAPP_PRODUCTPAGE_MESSAGE', $values['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE']);

			Configuration::updateValue('ANGARWHATSAPP_PHONE', Tools::getValue('ANGARWHATSAPP_PHONE'));
			Configuration::updateValue('ANGARWHATSAPP_PRODUCTLINK', Tools::getValue('ANGARWHATSAPP_PRODUCTLINK'));
			Configuration::updateValue('ANGARWHATSAPP_STYLE', Tools::getValue('ANGARWHATSAPP_STYLE'));
			Configuration::updateValue('ANGARWHATSAPP_POSITION', Tools::getValue('ANGARWHATSAPP_POSITION'));
			Configuration::updateValue('ANGARWHATSAPP_SIZE', Tools::getValue('ANGARWHATSAPP_SIZE'));

            $this->_clearCache($this->templateFile);
            return $this->displayConfirmation($this->l('The settings have been updated.'));
        }
        return '';
    }

    public function getContent()
    {
        return $this->postProcess().$this->renderForm();
    }

    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'tinymce' => true,
                    'title' => $this->l('Settings'),
                    'icon' => 'icon-cogs'
                ),
				'description' => $this->l('This module displays WhatsApp chat button.') . '<br>' . 
								 '<b>' . $this->l('Tip:') . '</b> ' . 
								 $this->l('Don\'t use in your phone number any brackets, dashes or other characters.') . '<br>' .
								 $this->l('For examples:') . '<br>' .
								 $this->l('Use your phone number in this format: 00123456789') . '<br>' .
								 $this->l('Don\'t use your phone number in this format: +00-(123)456789'),
				'tabs' => array(
                    'general' => $this->l('Settings'),
                    'productpage' => $this->l('Aks about product button'),
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('Whatsapp number'),
                        'tab' => 'general',
                        'name' => 'ANGARWHATSAPP_PHONE',
                    ),
                    array(
                        'type' => 'text',
                        'lang' => true,
                        'label' => $this->l('Default Whatsapp message'),
                        'tab' => 'general',
                        'name' => 'ANGARWHATSAPP_DEFAULT_MESSAGE',
                    ),
                    array(
                        'type' => 'radio',
                        'label' => $this->l('Button style'),
                        'tab' => 'general',
                        'name' => 'ANGARWHATSAPP_STYLE',
                        'values' => array(
                            array(
                                'id' => 'default',
                                'value' => 'default',
                                'label' => $this->l('Default')
                            ),
                            array(
                                'id' => 'pulse',
                                'value' => 'pulse',
                                'label' => $this->l('Pulse')
                            ),
                        ),
                    ),
                    array(
                        'type' => 'radio',
                        'label' => $this->l('Button possition'),
                        'tab' => 'general',
                        'name' => 'ANGARWHATSAPP_POSITION',
                        'values' => array(
                            array(
                                'id' => 'top_right',
                                'value' => 'top_right',
                                'label' => $this->l('Top right')
                            ),
                            array(
                                'id' => 'top_left',
                                'value' => 'top_left',
                                'label' => $this->l('Top left')
                            ),
                            array(
                                'id' => 'bottom_right',
                                'value' => 'bottom_right',
                                'label' => $this->l('Bottom right')
                            ),
                            array(
                                'id' => 'bottom_left',
                                'value' => 'bottom_left',
                                'label' => $this->l('Bottom left')
                            ),
                        ),
                    ),
                    array(
                        'type' => 'radio',
                        'label' => $this->l('Button size'),
                        'tab' => 'general',
                        'name' => 'ANGARWHATSAPP_SIZE',
                        'values' => array(
                            array(
                                'id' => '40px',
                                'value' => '40px',
                                'label' => $this->l('40px')
                            ),
                            array(
                                'id' => '50px',
                                'value' => '50px',
                                'label' => $this->l('50px')
                            ),
                            array(
                                'id' => '60px',
                                'value' => '60px',
                                'label' => $this->l('60px')
                            ),
                            array(
                                'id' => '70px',
                                'value' => '70px',
                                'label' => $this->l('70px')
                            ),
                            array(
                                'id' => '80px',
                                'value' => '80px',
                                'label' => $this->l('80px')
                            ),
                        ),
                    ),
                    array(
                        'type' => 'switch',
                        'label' => $this->l('Display Ask about product on the product page'),
                        'tab' => 'productpage',
                        'name' => 'ANGARWHATSAPP_PRODUCTLINK',
                        'is_bool' => true,
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('Disabled')
                            )
                        ),
                    ),
                    array(
                        'type' => 'text',
                        'lang' => true,
                        'label' => $this->l('Whatsapp message on the product page'),
                        'tab' => 'productpage',
                        'name' => 'ANGARWHATSAPP_PRODUCTPAGE_MESSAGE',
                    ),



                ),
                'submit' => array(
                    'title' => $this->l('Save')
                )
            ),
        );

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->default_form_language = $lang->id;
        $helper->module = $this;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $this->fields_form = array();
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitStoreConf';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'uri' => $this->getPathUri(),
            'fields_value' => $this->getConfigFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        $languages = Language::getLanguages(false);
        $fields = array();

        foreach ($languages as $lang) {
            $fields['ANGARWHATSAPP_DEFAULT_MESSAGE'][$lang['id_lang']] = Tools::getValue('ANGARWHATSAPP_DEFAULT_MESSAGE_'.$lang['id_lang'], Configuration::get('ANGARWHATSAPP_DEFAULT_MESSAGE', $lang['id_lang']));
            $fields['ANGARWHATSAPP_PRODUCTPAGE_MESSAGE'][$lang['id_lang']] = Tools::getValue('ANGARWHATSAPP_PRODUCTPAGE_MESSAGE_'.$lang['id_lang'], Configuration::get('ANGARWHATSAPP_PRODUCTPAGE_MESSAGE', $lang['id_lang']));
        }

        $fields['ANGARWHATSAPP_PHONE'] = Tools::getValue('ANGARWHATSAPP_PHONE', Configuration::get('ANGARWHATSAPP_PHONE'));
        $fields['ANGARWHATSAPP_PRODUCTLINK'] = Tools::getValue('ANGARWHATSAPP_PRODUCTLINK', Configuration::get('ANGARWHATSAPP_PRODUCTLINK'));
        $fields['ANGARWHATSAPP_STYLE'] = Tools::getValue('ANGARWHATSAPP_STYLE', Configuration::get('ANGARWHATSAPP_STYLE'));
        $fields['ANGARWHATSAPP_POSITION'] = Tools::getValue('ANGARWHATSAPP_POSITION', Configuration::get('ANGARWHATSAPP_POSITION'));
        $fields['ANGARWHATSAPP_SIZE'] = Tools::getValue('ANGARWHATSAPP_SIZE', Configuration::get('ANGARWHATSAPP_SIZE'));

        return $fields;
    }
}

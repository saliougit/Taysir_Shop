<?php
/**
* @author      Krzysztof Pecak
* @copyright   2024 Krzysztof Pecak
* @license     http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class AngarCookieinfo extends Module
{
    public function __construct()
    {
        $this->name = 'angarcookieinfo';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'angarthemes';
        $this->need_instance = 0;

        $this->bootstrap = true;
        parent::__construct();

        $this->displayName = $this->l('AT - Cookie banner');
        $this->description = $this->l('This module displays a simple cookie banner with information about cookies in your shop.');
        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);

        $this->templateFile = 'module:angarcookieinfo/views/templates/hook/angarcookieinfo.tpl';
    }

    public function install()
    {
        return
            parent::install() &&
            $this->registerHook('displayHeader') &&
            $this->registerHook('displayFooter') &&
            $this->installFixtures();
    }

	protected function installFixtures()
	{
		$languages = Language::getLanguages(false);
		$values = array();

		foreach ($languages as $lang) {

			$id_lang = (int)$lang['id_lang'];

			if ($id_lang == Language::getIdByIso('fr')) {
				$values['ANGARCOOKIEINFO_HTML'][$id_lang] = '<p>Ce magasin utilise des cookies pour améliorer votre expérience de navigation.</p><p>Pour plus d\'informations, consultez notre <a href="index.php?id_cms=2&controller=cms">Politique de confidentialité</a>.</p>';
			} elseif ($id_lang == Language::getIdByIso('es')) {
				$values['ANGARCOOKIEINFO_HTML'][$id_lang] = '<p>Esta tienda utiliza cookies para mejorar su experiencia de navegación.</p><p>Para obtener más información, consulte nuestra <a href="index.php?id_cms=2&controller=cms">Política de privacidad</a>.</p>';
			} elseif ($id_lang == Language::getIdByIso('pl')) {
				$values['ANGARCOOKIEINFO_HTML'][$id_lang] = '<p>Ten sklep używa plików cookie w celu poprawy jakości przeglądania.</p><p>Aby uzyskać więcej informacji, zobacz naszą <a href="index.php?id_cms=2&controller=cms">Politykę prywatności</a>.</p>';
			} elseif ($id_lang == Language::getIdByIso('it')) {
				$values['ANGARCOOKIEINFO_HTML'][$id_lang] = '<p>Questo negozio utilizza i cookie per migliorare la tua esperienza di navigazione.</p><p>Per ulteriori informazioni, consulta la nostra <a href="index.php?id_cms=2&controller=cms">Informativa sulla privacy</a>.</p>';
			} elseif ($id_lang == Language::getIdByIso('nl')) {
				$values['ANGARCOOKIEINFO_HTML'][$id_lang] = '<p>Deze winkel gebruikt cookies om uw browse-ervaring te verbeteren.</p><p>Voor meer informatie, zie ons <a href="index.php?id_cms=2&controller=cms">Privacybeleid</a>.</p>';
			} elseif ($id_lang == Language::getIdByIso('de')) {
				$values['ANGARCOOKIEINFO_HTML'][$id_lang] = '<p>Dieser Shop verwendet Cookies, um Ihr Surferlebnis zu verbessern.</p><p>Weitere Informationen finden Sie in unserer <a href="index.php?id_cms=2&controller=cms">Datenschutzerklärung</a>.</p>';
			} elseif ($id_lang == Language::getIdByIso('cs')) {
				$values['ANGARCOOKIEINFO_HTML'][$id_lang] = '<p>Tento obchod používá cookies ke zlepšení vašeho zážitku z prohlížení.</p><p>Další informace naleznete v našich <a href="index.php?id_cms=2&controller=cms">Zásadách ochrany osobních údajů</a>.</p>';
			} else {
				$values['ANGARCOOKIEINFO_HTML'][$id_lang] = '<p>This shop uses cookies to improve your browsing experience.</p><p>For more information, see our <a href="index.php?id_cms=2&controller=cms">Privacy Policy</a>.</p>';
			}

			if ($id_lang == Language::getIdByIso('fr')) {
				$values['ANGARCOOKIEINFO_TEXTLANG1'][$id_lang] = 'J\'accepte';
			} elseif ($id_lang == Language::getIdByIso('es')) {
				$values['ANGARCOOKIEINFO_TEXTLANG1'][$id_lang] = 'Aceptar';
			} elseif ($id_lang == Language::getIdByIso('pl')) {
				$values['ANGARCOOKIEINFO_TEXTLANG1'][$id_lang] = 'Akceptuję';
			} elseif ($id_lang == Language::getIdByIso('it')) {
				$values['ANGARCOOKIEINFO_TEXTLANG1'][$id_lang] = 'Accettare';
			} elseif ($id_lang == Language::getIdByIso('nl')) {
				$values['ANGARCOOKIEINFO_TEXTLANG1'][$id_lang] = 'Aanvaarden';
			} elseif ($id_lang == Language::getIdByIso('de')) {
				$values['ANGARCOOKIEINFO_TEXTLANG1'][$id_lang] = 'Akzeptieren';
			} elseif ($id_lang == Language::getIdByIso('cs')) {
				$values['ANGARCOOKIEINFO_TEXTLANG1'][$id_lang] = 'Akceptovat';
			} else {
				$values['ANGARCOOKIEINFO_TEXTLANG1'][$id_lang] = 'Accept';
			}

			if ($id_lang == Language::getIdByIso('fr')) {
				$values['ANGARCOOKIEINFO_TEXTLANG2'][$id_lang] = 'Sortie';
			} elseif ($id_lang == Language::getIdByIso('es')) {
				$values['ANGARCOOKIEINFO_TEXTLANG2'][$id_lang] = 'Salir';
			} elseif ($id_lang == Language::getIdByIso('pl')) {
				$values['ANGARCOOKIEINFO_TEXTLANG2'][$id_lang] = 'Wychodzę';
			} elseif ($id_lang == Language::getIdByIso('it')) {
				$values['ANGARCOOKIEINFO_TEXTLANG2'][$id_lang] = 'Uscita';
			} elseif ($id_lang == Language::getIdByIso('nl')) {
				$values['ANGARCOOKIEINFO_TEXTLANG2'][$id_lang] = 'Afsluiten';
			} elseif ($id_lang == Language::getIdByIso('de')) {
				$values['ANGARCOOKIEINFO_TEXTLANG2'][$id_lang] = 'Beenden';
			} elseif ($id_lang == Language::getIdByIso('de')) {
				$values['ANGARCOOKIEINFO_TEXTLANG2'][$id_lang] = 'Výstup';
			} else {
				$values['ANGARCOOKIEINFO_TEXTLANG2'][$id_lang] = 'Exit';
			}

			if ($id_lang == Language::getIdByIso('fr')) {
				$values['ANGARCOOKIEINFO_TEXTLANG3'][$id_lang] = 'Cookies';
			} elseif ($id_lang == Language::getIdByIso('es')) {
				$values['ANGARCOOKIEINFO_TEXTLANG3'][$id_lang] = 'Cookies';
			} elseif ($id_lang == Language::getIdByIso('pl')) {
				$values['ANGARCOOKIEINFO_TEXTLANG3'][$id_lang] = 'Pliki cookies';
			} elseif ($id_lang == Language::getIdByIso('it')) {
				$values['ANGARCOOKIEINFO_TEXTLANG3'][$id_lang] = 'Cookies';
			} elseif ($id_lang == Language::getIdByIso('nl')) {
				$values['ANGARCOOKIEINFO_TEXTLANG3'][$id_lang] = 'Cookies';
			} elseif ($id_lang == Language::getIdByIso('de')) {
				$values['ANGARCOOKIEINFO_TEXTLANG3'][$id_lang] = 'Cookies';
			} elseif ($id_lang == Language::getIdByIso('cs')) {
				$values['ANGARCOOKIEINFO_TEXTLANG3'][$id_lang] = 'Cookies';
			} else {
				$values['ANGARCOOKIEINFO_TEXTLANG3'][$id_lang] = 'Cookies';
			}

		}

		Configuration::updateValue('ANGARCOOKIEINFO_HTML', $values['ANGARCOOKIEINFO_HTML'], true);
		Configuration::updateValue('ANGARCOOKIEINFO_TEXTLANG1', $values['ANGARCOOKIEINFO_TEXTLANG1']);
		Configuration::updateValue('ANGARCOOKIEINFO_TEXTLANG2', $values['ANGARCOOKIEINFO_TEXTLANG2']);
		Configuration::updateValue('ANGARCOOKIEINFO_TEXTLANG3', $values['ANGARCOOKIEINFO_TEXTLANG3']);

		Configuration::updateValue('ANGARCOOKIEINFO_TEXT1', '#ffffff'); // Cookie banner - background color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT2', '#000000'); // Cookie banner - text color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT3', 'position_left');
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT4', '#222222'); // Accept button - background color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT5', '#ffffff'); // Accept button - text color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT6', '#ffcf00'); // Accept button - background hover color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT7', '#000000'); // Accept button - text hover color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT8', 'https://www.google.com/');
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT9', '#ffffff'); // Exit button - background color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT10', '#222222'); // Exit button - text color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT11', '#ffcf00'); // Exit button - background hover color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT12', '#000000'); // Exit button - text hover color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT13', '1');
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT14', 'display-icon');
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT15', '350');
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT16', '#222222'); // Accept button - border color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT17', '#ffcf00'); // Accept button - border hover color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT18', '#222222'); // Exit button - border color
		Configuration::updateValue('ANGARCOOKIEINFO_TEXT19', '#ffcf00'); // Exit button - border hover color

		return true;
	}

    public function uninstall()
    {
        Configuration::deleteByName('ANGARCOOKIEINFO_HTML');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXTLANG1');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXTLANG2');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXTLANG3');

        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT1');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT2');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT3');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT4');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT5');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT6');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT7');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT8');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT9');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT10');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT11');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT12');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT13');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT14');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT15');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT16');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT17');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT18');
        Configuration::deleteByName('ANGARCOOKIEINFO_TEXT19');

        return parent::uninstall();
    }

    public function hookDisplayFooter($params)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId('angarcookieinfo'))) {
            $this->smarty->assign(array(
                'angarcookieinfo_html' => Configuration::get('ANGARCOOKIEINFO_HTML', $this->context->language->id),
                'angarcookieinfo_textlang1' => Configuration::get('ANGARCOOKIEINFO_TEXTLANG1', $this->context->language->id),
                'angarcookieinfo_textlang2' => Configuration::get('ANGARCOOKIEINFO_TEXTLANG2', $this->context->language->id),
                'angarcookieinfo_textlang3' => Configuration::get('ANGARCOOKIEINFO_TEXTLANG3', $this->context->language->id),

                'angarcookieinfo_text1' => Configuration::get('ANGARCOOKIEINFO_TEXT1'),
                'angarcookieinfo_text2' => Configuration::get('ANGARCOOKIEINFO_TEXT2'),
                'angarcookieinfo_text3' => Configuration::get('ANGARCOOKIEINFO_TEXT3'),
                'angarcookieinfo_text4' => Configuration::get('ANGARCOOKIEINFO_TEXT4'),
                'angarcookieinfo_text5' => Configuration::get('ANGARCOOKIEINFO_TEXT5'),
                'angarcookieinfo_text6' => Configuration::get('ANGARCOOKIEINFO_TEXT6'),
                'angarcookieinfo_text7' => Configuration::get('ANGARCOOKIEINFO_TEXT7'),
                'angarcookieinfo_text8' => Configuration::get('ANGARCOOKIEINFO_TEXT8'),
                'angarcookieinfo_text9' => Configuration::get('ANGARCOOKIEINFO_TEXT9'),
                'angarcookieinfo_text10' => Configuration::get('ANGARCOOKIEINFO_TEXT10'),
                'angarcookieinfo_text11' => Configuration::get('ANGARCOOKIEINFO_TEXT11'),
                'angarcookieinfo_text12' => Configuration::get('ANGARCOOKIEINFO_TEXT12'),
                'angarcookieinfo_text13' => Configuration::get('ANGARCOOKIEINFO_TEXT13'),
                'angarcookieinfo_text14' => Configuration::get('ANGARCOOKIEINFO_TEXT14'),
                'angarcookieinfo_text15' => Configuration::get('ANGARCOOKIEINFO_TEXT15'),
                'angarcookieinfo_text16' => Configuration::get('ANGARCOOKIEINFO_TEXT16'),
                'angarcookieinfo_text17' => Configuration::get('ANGARCOOKIEINFO_TEXT17'),
                'angarcookieinfo_text18' => Configuration::get('ANGARCOOKIEINFO_TEXT18'),
                'angarcookieinfo_text19' => Configuration::get('ANGARCOOKIEINFO_TEXT19')

            ));
        }

        return $this->display(__FILE__, 'views/templates/front/angarcookieinfo.tpl', $this->getCacheId('angarcookieinfo'));
    }

    public function hookDisplayHeader($params)
    {
        $this->context->controller->addCSS($this->_path.'views/css/angarcookieinfo.css', 'all');
    }

    public function postProcess()
    {
        if (Tools::isSubmit('submitStoreConf')) {
            $languages = Language::getLanguages(false);
            $values = array();

            foreach ($languages as $lang) {
                $values['ANGARCOOKIEINFO_HTML'][$lang['id_lang']] = Tools::getValue('ANGARCOOKIEINFO_HTML_'.$lang['id_lang']);
                $values['ANGARCOOKIEINFO_TEXTLANG1'][$lang['id_lang']] = Tools::getValue('ANGARCOOKIEINFO_TEXTLANG1_'.$lang['id_lang']);
                $values['ANGARCOOKIEINFO_TEXTLANG2'][$lang['id_lang']] = Tools::getValue('ANGARCOOKIEINFO_TEXTLANG2_'.$lang['id_lang']);
                $values['ANGARCOOKIEINFO_TEXTLANG3'][$lang['id_lang']] = Tools::getValue('ANGARCOOKIEINFO_TEXTLANG3_'.$lang['id_lang']);
            }
 
            Configuration::updateValue('ANGARCOOKIEINFO_HTML', $values['ANGARCOOKIEINFO_HTML'], true);
            Configuration::updateValue('ANGARCOOKIEINFO_TEXTLANG1', $values['ANGARCOOKIEINFO_TEXTLANG1']);
            Configuration::updateValue('ANGARCOOKIEINFO_TEXTLANG2', $values['ANGARCOOKIEINFO_TEXTLANG2']);
            Configuration::updateValue('ANGARCOOKIEINFO_TEXTLANG3', $values['ANGARCOOKIEINFO_TEXTLANG3']);

			Configuration::updateValue('ANGARCOOKIEINFO_TEXT1', Tools::getValue('ANGARCOOKIEINFO_TEXT1'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT2', Tools::getValue('ANGARCOOKIEINFO_TEXT2'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT3', Tools::getValue('ANGARCOOKIEINFO_TEXT3'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT4', Tools::getValue('ANGARCOOKIEINFO_TEXT4'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT5', Tools::getValue('ANGARCOOKIEINFO_TEXT5'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT6', Tools::getValue('ANGARCOOKIEINFO_TEXT6'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT7', Tools::getValue('ANGARCOOKIEINFO_TEXT7'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT8', Tools::getValue('ANGARCOOKIEINFO_TEXT8'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT9', Tools::getValue('ANGARCOOKIEINFO_TEXT9'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT10', Tools::getValue('ANGARCOOKIEINFO_TEXT10'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT11', Tools::getValue('ANGARCOOKIEINFO_TEXT11'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT12', Tools::getValue('ANGARCOOKIEINFO_TEXT12'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT13', Tools::getValue('ANGARCOOKIEINFO_TEXT13'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT14', Tools::getValue('ANGARCOOKIEINFO_TEXT14'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT15', Tools::getValue('ANGARCOOKIEINFO_TEXT15'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT16', Tools::getValue('ANGARCOOKIEINFO_TEXT16'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT17', Tools::getValue('ANGARCOOKIEINFO_TEXT17'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT18', Tools::getValue('ANGARCOOKIEINFO_TEXT18'));
			Configuration::updateValue('ANGARCOOKIEINFO_TEXT19', Tools::getValue('ANGARCOOKIEINFO_TEXT19'));

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
                'tabs' => array(
                    'cookie_banner' => $this->l('Cookie banner'),
                    'cookie_accept' => $this->l('Accept button'),
                    'cookie_exit' => $this->l('Exit button')
                ),
                'input' => array(

                    array(
						'tab' => 'cookie_banner',
                        'type' => 'text',
                        'lang' => true,
                        'label' => $this->l('Cookie banner - title'),
                        'name' => 'ANGARCOOKIEINFO_TEXTLANG3',
                    ),

                    array(
						'tab' => 'cookie_banner',
                        'type' => 'textarea',
                        'lang' => true,
                        'autoload_rte' => true,
                        'label' => $this->l('Cookie banner - text'),
                        'name' => 'ANGARCOOKIEINFO_HTML',
                    ),
                    array(
						'tab' => 'cookie_banner',
                        'type' => 'color',
                        'label' => $this->l('Cookie banner - background color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT1',
                    ),
                    array(
						'tab' => 'cookie_banner',
                        'type' => 'color',
                        'label' => $this->l('Cookie banner - text color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT2',
                    ),
                    array(
						'tab' => 'cookie_banner',
                        'type' => 'text',
                        'label' => $this->l('Cookie banner - width'),
                        'name' => 'ANGARCOOKIEINFO_TEXT15',
                        'desc' => $this->l('The width of the cookie banner in the left, right, center and popup positions'),
						'suffix' => 'px',
						'col' => 4
                    ),
                    array(
						'tab' => 'cookie_banner',
                        'type' => 'radio',
                        'label' => $this->l('Cookie banner - position'),
                        'name' => 'ANGARCOOKIEINFO_TEXT3',
                        'values' => array(
                            array(
                                'id' => 'position_bottom',
                                'value' => 'position_bottom',
                                'label' => $this->l('Bottom')
                            ),
                            array(
                                'id' => 'position_left',
                                'value' => 'position_left',
                                'label' => $this->l('Left')
                            ),
                            array(
                                'id' => 'position_right',
                                'value' => 'position_right',
                                'label' => $this->l('Right')
                            ),
                            array(
                                'id' => 'position_center',
                                'value' => 'position_center',
                                'label' => $this->l('Center')
                            ),
                            array(
                                'id' => 'position_popup',
                                'value' => 'position_popup',
                                'label' => $this->l('Popup (force customer to accept cookies)')
                            ),
                        ),
                    ),
                    array(
						'tab' => 'cookie_banner',
                        'type' => 'radio',
                        'label' => $this->l('Display cookie banner icon'),
                        'name' => 'ANGARCOOKIEINFO_TEXT14',
                        'values' => array(
                            array(
                                'id' => 'display-icon',
                                'value' => 'display-icon',
                                'label' => $this->l('Yes')
                            ),
                            array(
                                'id' => 'hide-icon',
                                'value' => 'hide-icon',
                                'label' => $this->l('No')
                            ),
                        ),
                    ),
                    array(
						'tab' => 'cookie_accept',
                        'type' => 'text',
                        'lang' => true,
                        'label' => $this->l('Accept button text'),
                        'name' => 'ANGARCOOKIEINFO_TEXTLANG1',
                    ),
                    array(
						'tab' => 'cookie_accept',
                        'type' => 'color',
                        'label' => $this->l('Accept button - background color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT4',
                    ),
                    array(
						'tab' => 'cookie_accept',
                        'type' => 'color',
                        'label' => $this->l('Accept button - border color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT16',
                    ),
                    array(
						'tab' => 'cookie_accept',
                        'type' => 'color',
                        'label' => $this->l('Accept button - text color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT5',
                    ),
                    array(
						'tab' => 'cookie_accept',
                        'type' => 'color',
                        'label' => $this->l('Accept button - background hover color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT6',
                    ),
                    array(
						'tab' => 'cookie_accept',
                        'type' => 'color',
                        'label' => $this->l('Accept button - border hover color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT17',
                    ),
                    array(
						'tab' => 'cookie_accept',
                        'type' => 'color',
                        'label' => $this->l('Accept button - text hover color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT7',
                    ),
                    array(
						'tab' => 'cookie_exit',
                        'type' => 'switch',
                        'label' => $this->l('Display exit button'),
                        'name' => 'ANGARCOOKIEINFO_TEXT13',
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
						'tab' => 'cookie_exit',
                        'type' => 'text',
                        'lang' => true,
                        'label' => $this->l('Exit button text'),
                        'name' => 'ANGARCOOKIEINFO_TEXTLANG2',
                    ),
                    array(
						'tab' => 'cookie_exit',
                        'type' => 'text',
                        'label' => $this->l('Exit button url'),
                        'name' => 'ANGARCOOKIEINFO_TEXT8',
                    ),
                    array(
						'tab' => 'cookie_exit',
                        'type' => 'color',
                        'label' => $this->l('Exit button - background color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT9',
                    ),
                    array(
						'tab' => 'cookie_exit',
                        'type' => 'color',
                        'label' => $this->l('Exit button - border color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT18',
                    ),
                    array(
						'tab' => 'cookie_exit',
                        'type' => 'color',
                        'label' => $this->l('Exit button - text color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT10',
                    ),
                    array(
						'tab' => 'cookie_exit',
                        'type' => 'color',
                        'label' => $this->l('Exit button - background hover color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT11',
                    ),
                    array(
						'tab' => 'cookie_exit',
                        'type' => 'color',
                        'label' => $this->l('Exit button - border hover color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT19',
                    ),
                    array(
						'tab' => 'cookie_exit',
                        'type' => 'color',
                        'label' => $this->l('Exit button - text hover color'),
                        'name' => 'ANGARCOOKIEINFO_TEXT12',
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
            $fields['ANGARCOOKIEINFO_HTML'][$lang['id_lang']] = Tools::getValue('ANGARCOOKIEINFO_HTML_'.$lang['id_lang'], Configuration::get('ANGARCOOKIEINFO_HTML', $lang['id_lang']));
            $fields['ANGARCOOKIEINFO_TEXTLANG1'][$lang['id_lang']] = Tools::getValue('ANGARCOOKIEINFO_TEXTLANG1_'.$lang['id_lang'], Configuration::get('ANGARCOOKIEINFO_TEXTLANG1', $lang['id_lang']));
            $fields['ANGARCOOKIEINFO_TEXTLANG2'][$lang['id_lang']] = Tools::getValue('ANGARCOOKIEINFO_TEXTLANG2_'.$lang['id_lang'], Configuration::get('ANGARCOOKIEINFO_TEXTLANG2', $lang['id_lang']));
            $fields['ANGARCOOKIEINFO_TEXTLANG3'][$lang['id_lang']] = Tools::getValue('ANGARCOOKIEINFO_TEXTLANG3_'.$lang['id_lang'], Configuration::get('ANGARCOOKIEINFO_TEXTLANG3', $lang['id_lang']));
        }

        $fields['ANGARCOOKIEINFO_TEXT1'] = Tools::getValue('ANGARCOOKIEINFO_TEXT1', Configuration::get('ANGARCOOKIEINFO_TEXT1'));
        $fields['ANGARCOOKIEINFO_TEXT2'] = Tools::getValue('ANGARCOOKIEINFO_TEXT2', Configuration::get('ANGARCOOKIEINFO_TEXT2'));
        $fields['ANGARCOOKIEINFO_TEXT3'] = Tools::getValue('ANGARCOOKIEINFO_TEXT3', Configuration::get('ANGARCOOKIEINFO_TEXT3'));
        $fields['ANGARCOOKIEINFO_TEXT4'] = Tools::getValue('ANGARCOOKIEINFO_TEXT4', Configuration::get('ANGARCOOKIEINFO_TEXT4'));
        $fields['ANGARCOOKIEINFO_TEXT5'] = Tools::getValue('ANGARCOOKIEINFO_TEXT5', Configuration::get('ANGARCOOKIEINFO_TEXT5'));
        $fields['ANGARCOOKIEINFO_TEXT6'] = Tools::getValue('ANGARCOOKIEINFO_TEXT6', Configuration::get('ANGARCOOKIEINFO_TEXT6'));
        $fields['ANGARCOOKIEINFO_TEXT7'] = Tools::getValue('ANGARCOOKIEINFO_TEXT7', Configuration::get('ANGARCOOKIEINFO_TEXT7'));
        $fields['ANGARCOOKIEINFO_TEXT8'] = Tools::getValue('ANGARCOOKIEINFO_TEXT8', Configuration::get('ANGARCOOKIEINFO_TEXT8'));
        $fields['ANGARCOOKIEINFO_TEXT9'] = Tools::getValue('ANGARCOOKIEINFO_TEXT9', Configuration::get('ANGARCOOKIEINFO_TEXT9'));
        $fields['ANGARCOOKIEINFO_TEXT10'] = Tools::getValue('ANGARCOOKIEINFO_TEXT10', Configuration::get('ANGARCOOKIEINFO_TEXT10'));
        $fields['ANGARCOOKIEINFO_TEXT11'] = Tools::getValue('ANGARCOOKIEINFO_TEXT11', Configuration::get('ANGARCOOKIEINFO_TEXT11'));
        $fields['ANGARCOOKIEINFO_TEXT12'] = Tools::getValue('ANGARCOOKIEINFO_TEXT12', Configuration::get('ANGARCOOKIEINFO_TEXT12'));
        $fields['ANGARCOOKIEINFO_TEXT13'] = Tools::getValue('ANGARCOOKIEINFO_TEXT13', Configuration::get('ANGARCOOKIEINFO_TEXT13'));
        $fields['ANGARCOOKIEINFO_TEXT14'] = Tools::getValue('ANGARCOOKIEINFO_TEXT14', Configuration::get('ANGARCOOKIEINFO_TEXT14'));
        $fields['ANGARCOOKIEINFO_TEXT15'] = Tools::getValue('ANGARCOOKIEINFO_TEXT15', Configuration::get('ANGARCOOKIEINFO_TEXT15'));
        $fields['ANGARCOOKIEINFO_TEXT16'] = Tools::getValue('ANGARCOOKIEINFO_TEXT16', Configuration::get('ANGARCOOKIEINFO_TEXT16'));
        $fields['ANGARCOOKIEINFO_TEXT17'] = Tools::getValue('ANGARCOOKIEINFO_TEXT17', Configuration::get('ANGARCOOKIEINFO_TEXT17'));
        $fields['ANGARCOOKIEINFO_TEXT18'] = Tools::getValue('ANGARCOOKIEINFO_TEXT18', Configuration::get('ANGARCOOKIEINFO_TEXT18'));
        $fields['ANGARCOOKIEINFO_TEXT19'] = Tools::getValue('ANGARCOOKIEINFO_TEXT19', Configuration::get('ANGARCOOKIEINFO_TEXT19'));

        return $fields;
    }
}

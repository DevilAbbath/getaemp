# getaemp APP

Aplicación de postulaciones de trabajos para una empresa

## Descripción

Esta página funciona principalmente mediante el uso de un CRUD para el manejo de las ofertas de trabajo, asi como las postulaciones dejadas por otros usuarios y su gestión a través de una base de datos, en este caso PostgreSQL. Hace uso de aws para poder trabajar con tanto fotos de perfil de cada empleado, entre sus características se encuentra:

- Generación de ofertas de trabajo por parte de un administrador.
- Creación de usuarios solo por administradores.
- Postulación a los diferentes puestos de trabajo por parte de los usuarios.
- Vista en cada oferta de trabajo sobre los postulantes con acceso a su información.
- Capacidad de los usuarios de poder editar su perfil para llamar la atención de su jefe.
- Vista para los visitantes solo de index.
- Restricciones a los usuarios a algunas opciones, como lo son editar borrar o crear ofertas.

## Cuentas de prueba

Cuenta administrador:

- user: admin@mail.com
- password: 123456


## Visuales

Vista de bienvenida a la página:

![Vista principal](/public/prt2.png)

Paginas con las ofertas laborales.

![Ofertas laborales](/public/prt1.png)

Vista de administrador de las postulaciones a una oferta laboral.

![Postulaciones de los usuarios](/public/prt3.png)

Muestra las Postulaciones realizadas como Usuario:

![Información de Usuario](/public/prt4.png)

Editar Perfil:

![Editar Perfil](/public/prt6.png)

## Empezando 🚀

Estas instrucciones te guiarán para obtener una copia de este proyecto en funcionamiento en tu máquina local con fines de desarrollo y pruebas.

### Pre-requisitos 📋

- Sistema Operativo: Windows, Ubuntu o macOS
- Lenguaje de programación: Ruby 3.2.2
- Framework Rails: 7.0.6
- PostgreSQL: 14.8

### Instalación 🔧

Clona el repositorio con el siguiente comando:

```bash
git clone https://github.com/DevilAbbath/getaemp
```

En la terminal, accede a la carpeta donde se encuentra el repositorio y ejecuta (recuerda que para que esto funcione, debes tener instalado Ruby y la gema bundle):

```bash
bundle install
```

Inicia la base de datos con el siguiente comando:

```bash
rails db:create db:migrate db:seed
```

Finalmente, ejecuta el proyecto con el siguiente comando y ve a la dirección IP que aparecerá en la consola:

```bash
rails s
```

## Ejecutando las Pruebas ⚙️

Para ejecutar las pruebas primero asegúrate de haber ejecutado un bundle con el siguiente comando:

```bash
bundle install
```

Luego procede a ejecutar todos los test si los deseas usando el comando:

```bash
rails t
```

Si deseas hacer un test en particular ejecuta rails t y agrega el test que desees por ejemplo:

```bash
rails t test/controllers/job_applications_controller_test.rb 
# esto ejecutara el test de job_applications 
```

### Pruebas de Principio a Fin 🔩

Los test en este proyecto utilizan minitest, selenium y capybara. Se realizan tanto al Crud de ofertas de trabajo y se encuentran en el controlador Jobs de la carpeta test, como también se realiza test al flujo que sigue un usuario desde que ingresa a la pagina, hace login hasta la creación de una postulación por parte de un usuario.

### Pruebas de Estilo de Código ⌨️

En el siguiente código se mostrara el test de flujo de un usuario desde que ingresa a la página hasta que postula a un trabajo, dicho test también se encuentra en test/controllers/jobs_applications_controller_test.rb.

```ruby
test 'user flow to create a new application to a job' do
    # Entramos a la application y hacemos click en el link para iniciar session
    visit root_path

    # Verifico si estoy en la pagina de login para poder trabajar con el formulario
    click_link 'iniciar sesión'
    assert current_path == new_user_session_path

    # Rellenamos el formulario de login
    fill_in('user_email', with: @user.email)
    fill_in('user_password', with: '123456')
    click_on 'Log in'

    # Comprobamos que la session se inicie con éxito y que estemos en la paginas de jobs
    assert_text 'Signed in successfully.'
    assert current_path == jobs_path

    # Nos dirigimos a la pagina del trabajo @job para postular
    click_link "job_#{@job.id}_link"
    assert_current_path job_path(@job)

    # Nos aseguramos que podemos postular y esto solo pasara si encontramos la form
    assert_no_text 'Ya te has postulado a esta oferta de trabajo.'
    page.assert_selector('form', text: 'Deja tu mensaje para postular')
    fill_in('job_application_message', with: 'Me encuentro postulando a esta nueva oportunidad laboral')

    # Completamos la postulación
    click_on 'Application'
    assert_text 'Tu postulación ha sido enviada con éxito.'

    # Finalmente comprobamos que ya estamos postulando
    assert_current_path job_path(@job)
    assert_text 'Ya te has postulado a esta oferta de trabajo.'
    assert_no_selector('form', text: 'Deja tu mensaje para postular')
  end
```

## Despliegue

Existen problemas con el despliegue ya que hay unos cobros extras realizados que no he podido pagar :/


## Construido Con 🛠️

- [Ruby](https://www.ruby-lang.org/es/) - El lenguaje utilizado
- [Ruby on Rails](https://rubyonrails.org) - El framework web utilizado
- [Ruby gems](https://rubygems.org) - Gestión de dependencias
- [Postgresql](https://www.postgresql.org) - Sistema de base de datos
- [Bootstrap](https://getbootstrap.com/) - Framework de CSS
- [Devise](https://github.com/heartcombo/devise) - Gema para autentificación y permisos.
- [Capybara](https://github.com/teamcapybara/capybara) - Gema para realizar test.
- [Simple_form](https://github.com/heartcombo/simple_form) - Facilitar el uso de forms.
- [Active Storage Validations](https://github.com/igorkasyanchuk/active_storage_validations) - Validación de active storage.
- [Figaro](https://github.com/laserlemon/figaro) - Configuración de ENV.

## Soporte

Si tienes algún problema o sugerencia, por favor abre un problema [aquí](https://github.com/DevilAbbath/getaemp/issues).

## Versionado 📌

Use [Git](https://git-scm.com) para el versionado.

## Autores ✒️

- **Erick Jaime Jara** - Encuéntrame en [github](https://github.com/DevilAbbath)

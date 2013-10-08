
default['radicale']['daemon_binary'] = "/usr/local/bin/radicale"

default['radicale']['config'] = {
  'server' => {
    'hosts' => '127.0.0.1:5232',
    'daemon' => 'False', # init script assumes False
    'ssl' => 'False',
    'dns_lookup' => 'False',
    'base_prefix' => '/',
    'realm' => 'Radicale' # unused by default
  },
  'encoding' => {
    'request' => 'utf-8',
    'stock' => 'utf-8'
  },
  'auth' => {
    'type' => 'None'
  },
  'rights' => {
    'type' => 'None',
    'file' => '/opt/radicale/rights' # unused by default
  },
  'storage' => {
    'type' => 'filesystem',
    'filesystem_folder' => '/opt/radicale/collections' # folder will be created but doesn't need to be used
  },
  'logging' => { # don't modify, cookbook manages this
    'config' => '/opt/radicale/logging',
    'debug' => 'False',
    'full_environment' => 'False'
  }
}

default['radicale']['logging'] = { # don't modify, cookbook manages this
  'loggers' => {
    'keys' => 'root'
  },
  'handlers' => {
    'keys' => 'console,file'
  },
  'formatters' => {
    'keys' => 'simple,full'
  },
  'logger_root' => {
    'level' => 'DEBUG',
    'handlers' => 'console,file'
  },
  'handler_console' => {
    'class' => 'StreamHandler',
    'level' => 'INFO',
    'args' => '(sys.stdout,)',
    'formatter' => 'simple'
  },
  'handler_file' => {
    'class' => 'FileHandler',
    'args' => '(\'/var/log/radicale.log\',)',
    'formatter' => 'full'
  },
  'formatter_simple' => {
    'format' => '%(message)s'
  },
  'formatter_full' => {
    'format' => '%(asctime)s - %(levelname)s: %(message)s'
  }
}

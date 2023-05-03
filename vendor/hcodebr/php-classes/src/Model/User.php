<?php

namespace Hcode\Model;

use \Hcode\DB\Sql;
use \Hcode\Mailer;
use \Hcode\Model;

class User extends Model{

    const SESSION = "User";
    const SECRET = "hcodePhp7_Secret";
    const METHOD = 'AES-256-CBC';

    public static function login($login, $password) {
        $sql = new Sql();

        $results = $sql->select("SELECT * FROM tb_users WHERE deslogin = :LOGIN", array(
            ":LOGIN"=>$login
        ));

        if(count($results) === 0) {
            throw new \Exception('Usuário inexistente ou senha inválida.');
        }

        $data = $results[0];

        if(password_verify($password, $data['despassword']) === true) {
            $user = new User();
        
            $user->setData($data);

            $_SESSION[User::SESSION] = $user->getValues();

            return $user;
        }
        else {
            throw new \Exception('Usuário inexistente ou senha inválida.');
        }
    
    }

    public static function verifyLogin($inadmin = true) {
        if(!isset($_SESSION[User::SESSION]) || !$_SESSION[User::SESSION] || !(int)$_SESSION[User::SESSION]['iduser'] > 0 || (bool)$_SESSION[User::SESSION]['inadmin'] !== $inadmin) {
            header('Location: /admin/login');
            exit;
        }
    }

    public static function logout() {
        $_SESSION[User::SESSION] = NULL;
    }

    public static function listAll() {
        $sql = new Sql();
        return $sql->select("SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) ORDER BY b.desperson");
    }

    public function save() {
        $sql = new Sql();

        //create procedures sql
        $results = $sql->select('CALL sp_users_save(:desperson, :deslogin, :despassword, :desemail, :nrphone, :inadmin)', 
        array(
            ":desperson"=>$this->getdesperson(),
            ":deslogin"=>$this->getdeslogin(),
            ":despassword"=>$this->getdespassword(),
            ":desemail"=>$this->getdesemail(),
            ":nrphone"=>$this->getnrphone(),
			":inadmin"=>$this->getinadmin(),
        ));

        $this->setData($results[0]);
    }

    public function get($iduser){

        $sql = new Sql();
        
        //create procedures sql
        $results = $sql->select('SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) WHERE a.iduser = :iduser', array(
            ':iduser'=>$iduser
        ));
        
        $this->setData($results[0]);
    
    }

    public function update() {
        $sql = new Sql();

        //create procedures sql
        $results = $sql->select('CALL sp_usersupdate_save(:iduser, :desperson, :deslogin, :despassword, :desemail, :nrphone, :inadmin)', 
        array(
            ":iduser"=>$this->getiduser(),
            ":desperson"=>$this->getdesperson(),
            ":deslogin"=>$this->getdeslogin(),
            ":despassword"=>$this->getdespassword(),
            ":desemail"=>$this->getdesemail(),
            ":nrphone"=>$this->getnrphone(),
			":inadmin"=>$this->getinadmin(),
        ));

        $this->setData($results[0]);
    }

    public function delete() {
        $sql = new Sql(); //create procedures sql
        $sql->query("CALL sp_users_delete(:iduser)", array(
            ":iduser"=>$this->getiduser()
        ));
    }

    static function _generateIV(){
        $iv = openssl_cipher_iv_length(User::METHOD);
        $hash = base64_encode(md5(User::SECRET));
        while(strlen($hash) < $iv){
            $hash = $hash.$hash;
        }
        return substr($hash, 0, $iv);
    }

    public static function getForgot($email) {
        $sql = new Sql(); //create procedures sql
        $results = $sql->select("SELECT * 
        FROM tb_persons a 
        INNER JOIN tb_users b USING(idperson) 
        WHERE a.desemail = :email;
        ", array(
            ":email"=>$email
        ));

        if(count($results) === 0) {
            throw new \Exception('Não foi possível recuperar a senha');
        }
        else {

            $data = $results[0];

            $results2 = $sql->select("CALL sp_userspasswordsrecoveries_create(:iduser, :desip)", array(
                ":iduser"=>$data["iduser"],
                ":desip"=>$_SERVER["REMOTE_ADDR"]
            ));

            if(count($results2) === 0) {
                throw new \Exception('Não foi possível recuperar a senha');
            }
            else {
                $dataRecovery = $results2[0];

                $enc_iv = self::_generateIV(User::SECRET, openssl_cipher_iv_length(User::METHOD));

                $code = base64_encode(openssl_encrypt($dataRecovery["idrecovery"], "aes-128-cbc", User::SECRET, 0, $enc_iv));

                $link = "https://www.hcodecommerce.com.br/admin/forgot/reset?code=$code";

                $mailer = new Mailer($data["desemail"], $data["desperson"], "Redefinir senha da hcode store", "forgot", array(
                    "name"=>$data["desperson"],
                    "link"=>$link
                ));

                $mailer->send();

                return $data;

            }
        }
    }
    

    public static function validForgotDecrypt($idrecovery) {

        $enc_iv = self::_generateIV(User::SECRET, openssl_cipher_iv_length(User::METHOD));
        
        $idrecovery = openssl_decrypt(base64_decode($idrecovery), "aes-128-cbc", User::SECRET, 0, $enc_iv);
    
        $sql = new SQL();

        $results = $sql->select("SELECT * FROM tb_userspasswordsrecoveries a INNER JOIN tb_users b USING(iduser) INNER JOIN tb_persons c 
            USING(idperson) WHERE a.idrecovery = 2 AND a.dtrecovery IS NULL AND DATE_ADD(a.dtregister, INTERVAL 1 HOUR) >= NOW();", array(
            ":idrecovery" => $idrecovery
        ));

        if(count($results) == 0) {
            throw new \Exception('Não foi possível recuperar a senha');
        }
        else {
            return $results[0];
        }
    }

    public function setFogotUsed($idrecovery) {
        $sql = new Sql();
        $sql->query("UPDATE tb_userspasswordsrecoveries SET dtrecovery = NOW() WHERE idrecovery = :idrecovery", array(
            ":idrecovery" => $idrecovery
        ));
    }

    public function setPassword($password) {
        $sql = new Sql();
        $sql->query('UPDATE tb_users SET despassword = :password WHERE iduser = :iduser',array(
            ":password" => $password,
            ":iduser"=>$this->getiduser()
        ));
    }

}

?>
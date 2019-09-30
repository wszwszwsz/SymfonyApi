<?php


namespace App\Controller;

use ApiPlatform\Core\Validator\ValidatorInterface;
use App\Entity\User;

class ResetPasswordAction
{
    /**
     * @var ValidatorInterface
     */
    private $validator;

    public function __construct(ValidatorInterface $validator)
    {
        $this->validator = $validator;
    }

    public function __invoke(User $data)
    {
//        // $reset = new ResetPasswordAction();
//        // $reset();
//        var_dump(
//            $data->getNewPassword(),
//            $data->getNewRetypedPassword(),
//            $data->getOldPassword());
//            $data->getRetypedPassword();
//        die;
        $this->validator->validate($data);
        // Validator is only called after we return the data from this action!
    }
}

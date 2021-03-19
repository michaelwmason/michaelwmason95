export class Email {
  emailAddress: string;
  subject: string;
  message: string;

  constructor(emailAddress: string, subject: string, message: string) {
    this.emailAddress = emailAddress;
    this.subject = subject;
    this.message = message;
  }
}

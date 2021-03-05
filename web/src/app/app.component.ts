import { Component, OnDestroy, OnInit } from '@angular/core'
import { FormBuilder, FormControl, FormGroup } from '@angular/forms'
import { Subscription } from 'rxjs'
import { EmailService } from './services/email.service/email.service'

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit, OnDestroy {
    form: FormGroup
    subs: Subscription[] = []
    constructor(
        private formBuilder: FormBuilder,
        private emailService: EmailService
    ) {}

    ngOnInit(): void {
        this.form = this.formBuilder.group({
            emailAddress: [],
            subject: [],
            message: [],
        })
    }

    ngOnDestroy(): void {
        this.subs.forEach((s) => s.unsubscribe())
    }

    email(): void {
        const emailAddress = this.form.get('emailAddress').value
        const subject = this.form.get('subject').value
        const message = this.form.get('message').value
        this.subs.push(
            this.emailService
                .sendEmail(emailAddress, subject, message)
                .subscribe()
        )
    }

    get emailAddress(): FormControl {
        return this.form.get('emailAddress') as FormControl
    }

    get subject(): FormControl {
        return this.form.get('subject') as FormControl
    }

    get message(): FormControl {
        return this.form.get('message') as FormControl
    }
}

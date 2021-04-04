import { HttpClient } from '@angular/common/http'
import { Injectable } from '@angular/core'
import { Observable } from 'rxjs'
import { Email } from 'src/app/models/email'
import { environment } from 'src/environments/environment'

@Injectable()
export class EmailService {
  constructor(private http: HttpClient) {}

  sendEmail(
    emailAddress: string,
    subject: string,
    message: string
  ): Observable<Email> {
    const email = new Email(emailAddress, subject, message)
    return this.http.post<Email>(`${environment.baseUrl}/email`, email)
  }
}

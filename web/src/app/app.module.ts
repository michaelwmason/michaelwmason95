import { BrowserModule } from '@angular/platform-browser'
import { NgModule } from '@angular/core'

import { AppRoutingModule } from './app-routing.module'
import { AppComponent } from './app.component'
import { FlexLayoutModule } from '@angular/flex-layout'
import { BrowserAnimationsModule } from '@angular/platform-browser/animations'
import { MatIconModule } from '@angular/material/icon'
import { MatButtonModule } from '@angular/material/button'
import { HttpClientModule } from '@angular/common/http'
import { EmailService } from './services/email.service/email.service'
import { ReactiveFormsModule } from '@angular/forms'
import { MatInputModule } from '@angular/material/input'
import { MatFormFieldModule } from '@angular/material/form-field'
import { MatDividerModule } from '@angular/material/divider'

@NgModule({
    declarations: [AppComponent],
    imports: [
        BrowserModule,
        AppRoutingModule,
        FlexLayoutModule,
        BrowserAnimationsModule,
        MatIconModule,
        HttpClientModule,
        MatButtonModule,
        ReactiveFormsModule,
        MatInputModule,
        MatFormFieldModule,
        MatDividerModule,
    ],
    providers: [EmailService],
    bootstrap: [AppComponent],
})
export class AppModule {}

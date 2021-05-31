import { BrowserModule } from '@angular/platform-browser'
import { NgModule } from '@angular/core'

import { AppRoutingModule } from './app-routing.module'
import { AppComponent } from './app.component'
import { FlexLayoutModule } from '@angular/flex-layout'
import { BrowserAnimationsModule } from '@angular/platform-browser/animations'
import { MatIconModule } from '@angular/material/icon'
import { MatButtonModule } from '@angular/material/button'
import { HttpClientModule } from '@angular/common/http'
import { EmailService } from './services/email/email.service'
import { ReactiveFormsModule } from '@angular/forms'
import { MatInputModule } from '@angular/material/input'
import { MatFormFieldModule } from '@angular/material/form-field'
import { MatDividerModule } from '@angular/material/divider'
import { NavigationService } from './services/navigation/navigation.service'
import { AboutMeComponent } from './components/about-me/about-me.component'
import { HomeComponent } from './components/home/home.component'
import { NavigationComponent } from './components/navigation/navigation.component'
import { SkillsAndAchievementsComponent } from './components/skills/skills-and-achievements.component'
import { MoreInfoComponent } from './components/more-info/more-info.component'

@NgModule({
    declarations: [
        AppComponent,
        AboutMeComponent,
        HomeComponent,
        NavigationComponent,
        SkillsAndAchievementsComponent,
        MoreInfoComponent,
    ],
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
    providers: [EmailService, NavigationService],
    bootstrap: [AppComponent],
})
export class AppModule {}

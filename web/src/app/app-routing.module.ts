import { NgModule } from '@angular/core'
import { Routes, RouterModule } from '@angular/router'
import { AboutMeComponent } from './components/about-me/about-me.component'
import { MoreInfoComponent } from './components/more-info/more-info.component'
import { HomeComponent } from './components/home/home.component'
import { SkillsAndAchievementsComponent } from './components/skills/skills-and-achievements.component'
import { Location } from './models/location'

const routes: Routes = [
    { path: '', redirectTo: `/${Location.HOME}`, pathMatch: 'full' },
    { path: `${Location.HOME}`, component: HomeComponent },
    { path: `${Location.ABOUT_ME}`, component: AboutMeComponent },
    {
        path: `${Location.SKILLS_AND_ACHIEVEMENTS}`,
        component: SkillsAndAchievementsComponent,
    },
    { path: `${Location.MORE_INFO}`, component: MoreInfoComponent },
]

@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule],
})
export class AppRoutingModule {}

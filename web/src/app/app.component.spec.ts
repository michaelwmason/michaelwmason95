import { TestBed, async, ComponentFixture } from '@angular/core/testing'
import { ReactiveFormsModule } from '@angular/forms'
import { RouterTestingModule } from '@angular/router/testing'
import { AppComponent } from './app.component'
import {
    HttpClientTestingModule,
    HttpTestingController,
} from '@angular/common/http/testing'
import { MaterialModule } from './modules/material.module'
import { TestModule } from './modules/test.module'
import { MediaChange, MediaObserver } from '@angular/flex-layout'
import { of } from 'rxjs'

describe('AppComponent', () => {
    let fixture: ComponentFixture<AppComponent>
    let component: AppComponent
    let mediaObserver: MediaObserver
    beforeEach(async(() => {
        TestBed.configureTestingModule({
            imports: [
                RouterTestingModule,
                ReactiveFormsModule,
                HttpClientTestingModule,
                MaterialModule,
                TestModule,
            ],
            declarations: [AppComponent],
            providers: [HttpTestingController],
        }).compileComponents()
    }))
    beforeEach(() => {
        fixture = TestBed.createComponent(AppComponent)
        component = fixture.componentInstance
        mediaObserver = TestBed.inject(MediaObserver)
    })

    it('should create the app', () => {
        expect(component).toBeTruthy()
    })
    describe('ngOnInit', () => {
        it('should get the media alias', (done) => {
            const mediaSpy = spyOn(
                mediaObserver,
                'asObservable'
            ).and.returnValue(of([{ mqAlias: 'xl' } as MediaChange]))
            fixture.detectChanges()
            component.mediaAlias$.subscribe((actual) => {
                expect(mediaSpy).toHaveBeenCalled()
                expect(actual).toEqual('xl')
                done()
            })
        })
    })
    describe('nav', () => {
        it('should get the element by id and scroll it into view', () => {
            const elementSpy = jasmine.createSpyObj('element', [
                'scrollIntoView',
            ])
            const documentSpy = spyOn(
                document,
                'querySelector'
            ).and.returnValue(elementSpy)
            component.nav('foo')
            expect(documentSpy).toHaveBeenCalledWith('#foo')
            expect(elementSpy.scrollIntoView).toHaveBeenCalled()
        })
    })
})
